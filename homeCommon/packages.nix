{
  config,
  pkgs,
  lib,
  ...
}:

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
    nodePackages.js-beautify
    nodePackages.npm
    nodePackages.jsonlint
    nodePackages.typescript
    nodePackages.yarn
    nodePackages.prettier
    nodePackages.aws-cdk
    sqlfluff
    symbola
    texliveSmall
    xorg.setxkbmap
  ];
}
