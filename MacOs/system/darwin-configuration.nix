{ config, pkgs, ... }:

let
  home = "/Users/benkio";
in
{
  imports = [ ../../systemCommon/systemConfig.nix ];

  services = {
    redis.enable = true;

    postgresql = {
      enable = true;
      package = (pkgs.postgresql.withPackages (p: [ p.postgis ]));
      dataDir = "${home}/postgresDataDir";
    };
  };

  launchd.user.agents = {
    postgresql.serviceConfig = {
      StandardErrorPath = "${home}/postgres.error.log";
      StandardOutPath = "${home}/postgres.log";
    };
  };

  homebrew = {
    enable = true;
    onActivation.upgrade = true;
    brews = [
      "coreutils"      # GNU Core Utilities
      "defaultbrowser" # Script to set default browser
      "gnu-sed"        # GNU SED Command
      "tgenv"          # A tool to manage multiples Terragrunt versions
      "tfenv"          # Terraform Version Manager
      "lychee"         # Link Checker
      "pkg-config"     # queries information about libraries
    ];
    casks = [
      "caffeine"           # Keep mac awake
      "calibre"            # Book management
      "dropbox"            # Dropbox
      "kdenlive"           # Video Editor
      "obs"                # Video/screen recorder
      "slack"              # Chat
      "musicbrainz-picard" # Audio Tagger
      "telegram-desktop"   # Chat
      "vlc"                # Video Player
      "xld"                # CD Ripper
      "zoom"               # Video Chat
    ];

  };

  system = {
    stateVersion = 6;
    defaults = {
      NSGlobalDomain = {
        AppleShowAllFiles = true;
        AppleInterfaceStyleSwitchesAutomatically = true;
        KeyRepeat = 1;
      };
      dock = {
        autohide = true;
        wvous-tr-corner = 10; # top right corner puts the display on sleep
      };
      finder.AppleShowAllFiles = true;

    };
  };

  programs = {
    bash.enable = true;
    direnv.enable = true;
    nix-index.enable = true;
    zsh.enable = false;
  };

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  environment.darwinConfig = "${home}/nix-config/MacOs/system/darwin-configuration.nix";

  nix.package = pkgs.nix;

  # Fix the user group because of a problem, if causes errors, try to remove it
  ids.gids.nixbld = 30000;
}
