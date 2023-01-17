{ config, pkgs, lib, ... }:

################################################
#                   Packages                   #
################################################
{

  nixpkgs.overlays = [ (self: super: {
    jdk11 = super.jdk11.overrideAttrs (oldAttrs:  {
        version = "11.0.17";
        src = super.fetchurl {
          url = "https://cdn.azul.com/zulu/bin/zulu11.60.19-ca-jdk11.0.17-macosx_x64.tar.gz ";
          sha256 = "sha256-8rL+gpKLmfArpg7U35iuOtZWQyNEFFX8l4dJinnA8mM=";
          curlOpts = "-H Referer:https://www.azul.com/downloads/zulu/";
        };
      });
  })];

  home.packages = with pkgs; [
    jdk11
    (pkgs.sbt.override { jre = pkgs.jdk11; })
    (pkgs.maven.override { jdk = pkgs.jdk11; })
  ];
}
