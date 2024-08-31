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
    persepolis # aria2c GUI
    cabal-install
    discord
    nodePackages.js-beautify
    nodePackages.npm
    nodePackages.typescript
    nodePackages.yarn
    nodePackages.prettier
    nodePackages.webtorrent-cli
    sqlfluff
    symbola
    zoom-us
  ];
}
