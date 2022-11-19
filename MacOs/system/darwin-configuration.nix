{ config, pkgs, ... }:

{
  imports =
    [
      ../../systemCommon/systemConfig.nix
    ];

  services = {
    redis.enable = true;

    postgresql = {
      enable = true;
      package = (pkgs.postgresql.withPackages (p: [ p.postgis ]) );
      dataDir = "/Users/benkio/postgresDataDir";
    };
  };

  launchd.user.agents = {
    postgresql.serviceConfig = {
      StandardErrorPath = "/Users/benkio/postgres.error.log";
      StandardOutPath = "/Users/benkio/postgres.log";
    };
    defaultWorkBrowser = {
      command = "osascript /Users/benkio/browser.scpt chromium";
      serviceConfig.StartCalendarInterval = [{ Hour = 9; }];
    };
    defaultPersonalBrowser = {
      command = "osascript /Users/benkio/browser.scpt firefox";
      serviceConfig.StartCalendarInterval = [{ Hour = 18; }];
    };
  };

  homebrew = {
    enable = true;
    autoUpdate = true;
    brews = [
      "irssi"
      "ntfs-3g-mac"
      "defaultbrowser"
    ];
    casks = [
      "caffeine"
      "chromium"
      "firefox"
      "kdenlive"
      "obs"
      "qbittorrent"
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
  environment.darwinConfig = "/Users/benkio/nix-config/MacOs/system/darwin-configuration.nix";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;
}
