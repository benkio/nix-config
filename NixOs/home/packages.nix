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
    feh
    filezilla
    jdk11
    libsForQt5.kdenlive
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
