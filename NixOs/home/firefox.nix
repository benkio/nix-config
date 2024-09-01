{
  config,
  pkgs,
  lib,
  ...
}:

{
  nixpkgs.config.packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
      inherit pkgs;
    };
  };

  programs.firefox = {
    enable = true;
    profiles.benkio = {
      id = 0;
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        vimium
        bitwarden
        grammarly
        xbrowsersync
        ublock-origin
        darkreader
      ];
      search.engines = {
        "Youtube".metaData.alias = "@yt";
        "Google".metaData.alias = "@g";
      };
    };
  };
}
