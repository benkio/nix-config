{ config, pkgs, lib, ... }:

###############################################################################
#                   Packages without specific configuration                   #
###############################################################################

{
  home.packages = with pkgs; [
    # BROKEN handbrake
    aspell
    aspellDicts.en
    aspellDicts.en-science
    aspellDicts.en-computers
    aspellDicts.it
    cabal-install
    discord
    direnv
    nodePackages.js-beautify
    nodePackages.npm
    nodePackages.typescript
    nodePackages.yarn
    sqlfluff
    symbola
    zoom-us
  ];
}
