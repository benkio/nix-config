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
    # BROKEN haskellPackages.ghc-mod
    amule
    bitwarden
    bleachbit
    calibre
    feh
    guvcview
    gnome.gnome-screenshot
    jdk
    libsForQt5.kdenlive
    lychee
    megasync
    qjackctl
    reaper
    slack
    soulseekqt
    sound-juicer
    telegram-desktop
    teamviewer
    unetbootin
    picard
    zoom-us
  ];
}
