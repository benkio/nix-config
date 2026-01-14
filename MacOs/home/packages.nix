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
    maven
    ntfs3g
    duti
  ];
}
