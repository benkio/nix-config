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
      enableDefaultConfig = false;
      matchBlocks = {
        "workIdentity" = {
          user = "git";
          identityFile = [
            "~/.ssh/id_ed25519"
            "~/.ssh/id_rsa"
          ];
          hostname = "github.com";
          extraOptions = {
            IdentitiesOnly = "yes";
            IdentityAgent = "none";
          };
        };
        "github.com" = {
          user = "git";
          hostname = "github.com";
          identityFile = [
            "~/.ssh/id_ed25519"
            "~/.ssh/id_rsa"
          ];
          extraOptions = {
            IdentitiesOnly = "yes";
            IdentityAgent = "none";
          };
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
      VAULT_ADDR = "url";
      AWS_SECRET_ACCESS_KEY = "bar";
      AWS_ACCESS_KEY_ID = "foo";
      SKAFFOLD_DEFAULT_REPO = "url";
      GOOGLE_APPLICATION_CREDENTIALS = "path-to-json-credential";
    };
    file.".config/git/workspace.gitconfig".text = ''
      [user]
        name = Enrico Benini
        email = workmail
        signingkey = signingkey

      [commit]
        gpgsign = true
    '';
  };
}
