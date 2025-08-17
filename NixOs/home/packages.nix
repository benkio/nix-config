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
    font-manager
    gnome.gnome-screenshot
    guvcview
    jdk
    libsForQt5.kdenlive
    lychee
    megasync
    picard
    qjackctl
    reaper
    slack
    sound-juicer
    teamviewer
    telegram-desktop
    unetbootin
    xorg.setxkbmap
    zoom-us
  ];
}
