{ config, pkgs, ... }:

let home = "/Users/benkio";
in {
  imports =
    [
      ../../systemCommon/systemConfig.nix
    ];

  services = {
    redis.enable = true;

    postgresql = {
      enable = true;
      package = (pkgs.postgresql.withPackages (p: [ p.postgis ]) );
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
      "defaultbrowser"
      "gnu-sed"
      "tgenv"
      "tfenv"
      "lychee"
    ];
    casks = [
      "caffeine"
      "dropbox"
      "firefox" # Check if it's finally fine with home manager (not ready October 2023)
      "kdenlive"
      "obs"
      #"slack"
      "musicbrainz-picard"
      "telegram-desktop"
      "vlc"
    ];

  };

  system.defaults = {
    NSGlobalDomain = {
      AppleShowAllFiles = true;
      AppleInterfaceStyleSwitchesAutomatically = true;
      KeyRepeat = 1;
    };
    dock = {
      autohide = true;
      wvous-tr-corner = 10; #top right corner puts the display on sleep
    };
    finder.AppleShowAllFiles = true;

  };


  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  environment.darwinConfig = "${home}/nix-config/MacOs/system/darwin-configuration.nix";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;
}
