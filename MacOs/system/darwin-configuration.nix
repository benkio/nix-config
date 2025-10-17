{ config, pkgs, ... }:

let
  home = "/Users/benkio";
in
{
  imports = [
    ../../systemCommon/systemConfig.nix
    ./homebrew.nix
    ./programs.nix
    ./services.nix
    ./work.nix
  ];

  system.primaryUser = "benkio";

  launchd.user.agents = {
    postgresql.serviceConfig = {
      StandardErrorPath = "${home}/postgres.error.log";
      StandardOutPath = "${home}/postgres.log";
    };
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

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  environment.darwinConfig = "${home}/nix-config/MacOs/system/darwin-configuration.nix";

  nix.package = pkgs.nix;

  # Fix the user group because of a problem, if causes errors, try to remove it
  ids.gids.nixbld = 350;
}
