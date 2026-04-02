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
    alt-tab-macos
    defaultbrowser
    google-chrome
    slack
    telegram-desktop
    zoom-us
    maven
    ntfs3g
    duti
  ];
}
