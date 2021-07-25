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
      package = pkgs.postgresql;
    };
  };

  fonts = {
    enableFontDir = true;
  };

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
