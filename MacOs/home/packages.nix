{ config, pkgs, lib, ... }:

###############################################################################
#                   Packages without specific configuration                   #
###############################################################################

{
  home.packages = with pkgs; [
    jdk11
    (pkgs.sbt.override { jre = pkgs.jdk11; })
  ];
}
