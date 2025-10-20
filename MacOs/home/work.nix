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
}
