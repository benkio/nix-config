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
          addKeysToAgent = "yes";
          identityFile = "~/.ssh/id_ed25519";
          hostname = "github.com";
        };
      };
    };
  };
  home = {
    sessionVariables = {
      # Generate it from the tap repository README
      # https://github.com/commercetools/homebrew-tap
      HOMEBREW_GITHUB_API_TOKEN = "";
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
