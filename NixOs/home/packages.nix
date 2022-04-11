{ config, pkgs, lib, ... }:

###############################################################################
#                   Packages without specific configuration                   #
###############################################################################

{
  home.packages = with pkgs; [
        # BROKEN haskellPackages.ghc-mod
    amule
    awscli
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
    jdk17
    libsForQt5.kdenlive
    megasync
    qjackctl
    reaper
    slack
    soulseekqt
    sound-juicer
    tdesktop #telegram-desktop
    teamviewer
    tixati
    unetbootin
    zoom-us
  ];
}
