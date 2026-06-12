{
  config,
  pkgs,
  lib,
  ...
}:

{
  programs = {
    ssh = {
      enable = true;
      settings = {
        "github.com" = {
          User = "git";
          HostName = "github.com";
          IdentityFile = [
            "~/.ssh/id_ed25519"
            "~/.ssh/id_rsa"
          ];
          IdentitiesOnly = true;
          IdentityAgent = "none";
        };
      };
    };
    git = {
      includes = [
        {
          contents = {
            user = {
              email = "work@example.com";
            };

            core = {
              sshCommand = "ssh -i ~/.ssh/id_ed25519";
            };
          };

          condition = "hasconfig:remote.*.url:git@github.com:WORK_ORGANIZATION/*";
        }
      ];
    };
  };
  home = {
    sessionVariables = {
      # Generate it from the tap repository README
      # https://github.com/commercetools/homebrew-tap
      HOMEBREW_GITHUB_API_TOKEN = "";
      HOMEBREW_ARTIFACT_REGISTRY_TOKEN = "";
      VAULT_ADDR = "url";
      AWS_SECRET_ACCESS_KEY = "bar";
      AWS_ACCESS_KEY_ID = "foo";
      SKAFFOLD_DEFAULT_REPO = "url";
      GOOGLE_APPLICATION_CREDENTIALS = "path-to-json-credential";
    };
    file.".config/git/workspace.gitconfig".text = ''
      [core]
      sshCommand = "ssh -o IdentitiesOnly=yes -o IdentityAgent=none -i ~/.ssh/id_ed25519 -i ~/.ssh/id_rsa"

      [user]
        name = Enrico Benini
        email = workmail
        signingkey = signingkey

      [commit]
        gpgsign = true
    '';
  };
}
