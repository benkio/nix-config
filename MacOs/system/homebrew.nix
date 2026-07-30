{ config, pkgs, ... }:

{
  homebrew = {
    enable = true;
    onActivation.upgrade = true;
    brews = [
      "smithy-cli" # CLI for smithy language
      "tfenv" # Terraform Version Manager
      "tgenv" # A tool to manage multiples Terragrunt versions
      "nicotine-plus" # Music P2P
    ];
    casks = [
      "caffeine" # Keep mac awake
      "calibre" # Book management
      "dropbox" # Dropbox
      "kdenlive" # Video Editor
      "macfuse" # NTFS Support
      "musicbrainz-picard" # Audio Tagger
      "obs" # Video/screen recorder
      "protonvpn" # Free VPN client
      "vlc" # Video Player
      "xld" # CD Ripper
    ];
  };
}
