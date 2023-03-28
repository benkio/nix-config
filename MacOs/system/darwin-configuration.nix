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

  launchd.daemons = {
    defaultWorkBrowser = {
      command = "osascript ${home}/browser.scpt chromium";
      serviceConfig.StartCalendarInterval = [
        { Hour = 9; Weekday = 1; }
        { Hour = 9; Weekday = 2; }
        { Hour = 9; Weekday = 3; }
        { Hour = 9; Weekday = 4; }
        { Hour = 9; Weekday = 5; }
      ];
    };
    defaultPersonalBrowser = {
      command = "osascript ${home}/browser.scpt firefox";
      serviceConfig.StartCalendarInterval = [{ Hour = 18; }];
    };
  };

  homebrew = {
    enable = true;
    autoUpdate = true;
    brews = [
      "awscli"
      "irssi"
      "ntfs-3g-mac"
      "defaultbrowser"
      "gnu-sed"
      "yt-dlp"
    ];
    casks = [
      "caffeine"
      "chromium"
      "firefox"
      "kdenlive"
      "obs"
      "slack"
    ];

  };

  system.defaults = {
    NSGlobalDomain = {
      AppleShowAllFiles = true;
      AppleInterfaceStyleSwitchesAutomatically = true;
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
