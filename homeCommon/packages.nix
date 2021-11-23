{ config, pkgs, lib, ... }:

###############################################################################
#                   Packages without specific configuration                   #
###############################################################################

{
  home.packages = with pkgs; [
    # BROKEN handbrake
    direnv
    ghcid
    hlint
    nodePackages.js-beautify
    nodePackages.npm
    nodePackages.typescript
    ormolu
    stack
    symbola
  ];
}
