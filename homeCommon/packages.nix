{ config, pkgs, lib, ... }:

###############################################################################
#                   Packages without specific configuration                   #
###############################################################################

{
  home.packages = with pkgs; [
    # BROKEN handbrake
    cabal-install
    direnv
    ghcid
    hlint
    nodePackages.js-beautify
    nodePackages.npm
    nodePackages.typescript
    nodePackages.yarn
    ormolu
    stack
    symbola
  ];
}
