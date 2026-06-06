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
    # BROKEN amule                  # P2P Sharing
    abcde # Audio CD estractor
    calibre # Book Management (Kindle)
    feh # Image Viewer
    font-manager # Font Manager for GTK
    kdePackages.kdenlive # Video Editor
    lychee # Link Checker
    picard # Audio Tagger
    qjackctl # QT Jack Audio Control
    reaper # Audio Editor
    telegram-desktop # Chat
    unetbootin # Linux/Windows Image Creator
    zoom-us # Video Calls
  ];
}
