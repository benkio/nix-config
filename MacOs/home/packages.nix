{
  config,
  pkgs,
  lib,
  ...
}:

################################################
#                   Packages                   #
################################################
{

  programs = {
    sbt.enable = true;
    zsh.enable = false;
  };
  home.packages = with pkgs; [
    raycast
    google-chrome
    slack
    telegram-desktop
    zoom-us
    maccy
    maven
    ntfs3g
    duti
  ];
}
