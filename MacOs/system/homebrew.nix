{ config, pkgs, ... }:

{
  homebrew = {
    enable = true;
    onActivation.upgrade = true;
    brews = [
      "coreutils" # GNU Core Utilities
      "defaultbrowser" # Script to set default browser
      "gnu-sed" # GNU SED Command
      "lychee" # Link Checker
      "pkg-config" # queries information about libraries
      "tfenv" # Terraform Version Manager
      "tgenv" # A tool to manage multiples Terragrunt versions
    ];
    casks = [
      "caffeine" # Keep mac awake
      "calibre" # Book management
      "dropbox" # Dropbox
      "google-chrome" # Web Browser
      "kdenlive" # Video Editor
      "musicbrainz-picard" # Audio Tagger
      "obs" # Video/screen recorder
      "slack" # Chat
      "telegram-desktop" # Chat
      "vlc" # Video Player
      "xld" # CD Ripper
      "zoom" # Video Chat
    ];
  };
}
