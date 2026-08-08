{ config, pkgs, ... }:

let
  home = "/Users/benkio";
in
{
  services = {

    postgresql = {
      enable = true;
      package = (pkgs.postgresql.withPackages (p: [ p.postgis ]));
      dataDir = "${home}/postgresDataDir";
    };

  };
}
