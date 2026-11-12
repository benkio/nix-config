{
  config,
  pkgs,
  lib,
  ...
}:

let
  workSopsFile = ../../secrets/work.yaml;
  hasWorkSecrets = builtins.pathExists workSopsFile;
  workspaceGitConfigDefault = ''
    [core]
    sshCommand = "ssh -o IdentitiesOnly=yes -o IdentityAgent=none -i ~/.ssh/id_ed25519 -i ~/.ssh/id_rsa"

    [commit]
      gpgsign = false
  '';
in
{
  sops = lib.mkIf hasWorkSecrets {
    defaultSopsFile = workSopsFile;
    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
    secrets = {
      git_signing_key = { };
      google_application_credentials = { };
      homebrew_github_api_token = { };
      skaffold_default_repo = { };
      vault_addr = { };
      work_email = { };
      work_organization = { };
    };
    templates."workspace.gitconfig".content = ''
      [core]
      sshCommand = "ssh -o IdentitiesOnly=yes -o IdentityAgent=none -i ~/.ssh/id_ed25519 -i ~/.ssh/id_rsa"
      [includeIf "hasconfig:remote.*.url:git@github.com:${config.sops.placeholder.work_organization}/*"]
        path = ~/.config/git/workspace-work.gitconfig
    '';
    # Work org always goes through the work key, even for fresh clones
    templates."work-url.gitconfig".content = ''
      [url "git@github-work:${config.sops.placeholder.work_organization}/"]
        insteadOf = git@github.com:${config.sops.placeholder.work_organization}/
        insteadOf = https://github.com/${config.sops.placeholder.work_organization}/
    '';
    templates."workspace-work.gitconfig".content = ''
      [core]
      sshCommand = "ssh -i ~/.ssh/id_ed25519"

      [user]
        name = Enrico Benini
        email = ${config.sops.placeholder.work_email}
        signingkey = ${config.sops.placeholder.git_signing_key}

      [commit]
        gpgsign = true
    '';
  };

  programs = {
    # Auth is over SSH only: no gh credential helper (`gh auth setup-git`)
    gh = {
      enable = true;
      gitCredentialHelper.enable = false;
      settings.git_protocol = "ssh";
    };
    # Plain ssh globally (overrides the personal `-i id_rsa` of homeCommon):
    # the key is picked per host by the ssh config below, because during
    # `git clone` no remote exists yet, so the includeIf hasconfig can't apply
    git.settings.core.sshCommand = lib.mkForce "ssh";
    ssh = {
      enable = true;
      settings = {
        "github.com" = {
          User = "git";
          HostName = "github.com";
          IdentityFile = [
            "~/.ssh/id_rsa"
            "~/.ssh/id_ed25519"
          ];
          IdentitiesOnly = true;
          IdentityAgent = "none";
        };
        "github-work" = {
          User = "git";
          HostName = "github.com";
          IdentityFile = "~/.ssh/id_ed25519";
          IdentitiesOnly = true;
          IdentityAgent = "none";
        };
      };
    };
  };
  home = {
    sessionVariables = {
      XDG_DATA_DIRS = "/opt/homebrew/share\${XDG_DATA_DIRS:+:\$XDG_DATA_DIRS}";
    }
    // (
      if hasWorkSecrets then
        {
          GOOGLE_APPLICATION_CREDENTIALS = config.sops.placeholder.google_application_credentials;
          HOMEBREW_GITHUB_API_TOKEN = config.sops.placeholder.homebrew_github_api_token;
          CIRCLE_CI_TOKEN = config.sops.placeholder.circle_ci_token;
          SKAFFOLD_DEFAULT_REPO = config.sops.placeholder.skaffold_default_repo;
          VAULT_ADDR = config.sops.placeholder.vault_addr;
        }
      else
        { }
    );
    file = {
      ".config/git/workspace.gitconfig" =
        if hasWorkSecrets then
          {
            source = config.lib.file.mkOutOfStoreSymlink config.sops.templates."workspace.gitconfig".path;
          }
        else
          {
            text = workspaceGitConfigDefault;
          };
    }
    // lib.optionalAttrs hasWorkSecrets {
      ".config/git/work-url.gitconfig".source =
        config.lib.file.mkOutOfStoreSymlink config.sops.templates."work-url.gitconfig".path;
      ".config/git/workspace-work.gitconfig".source =
        config.lib.file.mkOutOfStoreSymlink
          config.sops.templates."workspace-work.gitconfig".path;
    };
  };
}
