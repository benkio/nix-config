{ config, pkgs, lib, ... }:

###############################################################################
#                   Packages without specific configuration                   #
###############################################################################

{
  home.packages = with pkgs; [
        # BROKEN haskellPackages.ghc-mod
    amule
    bitwarden
    bleachbit
    calibre
    discord
    docker
    docker-compose
    feh
    filezilla
    guvcview
    gnome.gnome-screenshot
    jdk
    libsForQt5.kdenlive
    megasync
    qjackctl
    reaper
    slack
    sbt
    soulseekqt
    sound-juicer
    tdesktop #telegram-desktop
    teamviewer
    tixati
    unetbootin
    zoom-us
  ];
}
