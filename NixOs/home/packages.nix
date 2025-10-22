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
    # BROKEN abcde                  # Audio CD estractor
    # BROKEN amule                  # P2P Sharing
    bitwarden              # Password Manager
    bleachbit              # Linux Cleanup
    calibre                # Book Management (Kindle)
    feh                    # Image Viewer
    font-manager           # Font Manager for GTK
    rofi-screenshot        # Screenshot utility for Gnome
    guvcview               # Linux Software for managing camera
    kdePackages.kdenlive   # Video Editor
    lychee                 # Link Checker
    picard                 # Audio Tagger
    qjackctl               # QT Jack Audio Control
    reaper                 # Audio Editor
    slack                  # Chat
    teamviewer             # Desktop sharing application
    telegram-desktop       # Chat
    unetbootin             # Linux/Windows Image Creator
    xorg.setxkbmap         # Command to set keybindings
    zoom-us                # Video Calls
  ];
}
