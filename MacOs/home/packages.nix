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
    google-chrome
    slack
    maven
    duti
  ];
}
