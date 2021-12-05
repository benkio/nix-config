{ config, pkgs, lib, ... }:

{
  nixpkgs.config.packageOverrides = pkgs: {
     nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
    inherit pkgs;
    };
  };

  programs.firefox = {
    enable = true;
    extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        vimium
        bitwarden
        grammarly
        xbrowsersync # sync Id 4a1aea669e6d4c11be1cce243ff0ef76
      ];
    profiles.benkio.id = 0;
  };
}
