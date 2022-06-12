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

  launchd.user.agents.postgresql.serviceConfig = {
    StandardErrorPath = "/Users/benkio/postgres.error.log";
    StandardOutPath = "/Users/benkio/postgres.log";
  };

  fonts = {
    fontDir = true;
  };

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;
}
