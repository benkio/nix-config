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
    freac # Audio CD extractor
    calibre # Book Management (Kindle)
    feh # Image Viewer
    font-manager # Font Manager for GTK
    kdePackages.kdenlive # Video Editor
    lychee # Link Checker
    qjackctl # QT Jack Audio Control
    reaper # Audio Editor
    unetbootin # Linux/Windows Image Creator
  ];
}
