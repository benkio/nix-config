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
        vimium
        grammarly
      ];
    profiles.benkio.id = 0;
  };
}
