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
    # BROKEN font-manager # Font Manager for GTK
    amule                  # P2P Sharing
    abcde # Audio CD ripper (mp3)
    calibre # Book Management (Kindle)
    feh # Image Viewer
    kdePackages.kdenlive # Video Editor
    lychee # Link Checker
    qjackctl # QT Jack Audio Control
    reaper # Audio Editor
    unetbootin # Linux/Windows Image Creator
  ];
}
