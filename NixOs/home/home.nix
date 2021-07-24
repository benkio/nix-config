{ config, pkgs, lib, ... }:

{
  imports = [
    ./i3.nix
    ./firefox.nix
    ./packages.nix
    ./programs/programs.nix
    ../../common/emacsConfig.nix
    ../../common/bobPaintings.nix
    ../../common/packages.nix
    ../../common/homeConfig.nix
    ../../common/programs/programs.nix
  ];
  fonts.fontconfig.enable = true;

  services = {
    udiskie.enable = true;      # Mount external disks automatically
    gpg-agent = {
      enable = true;
      defaultCacheTtl = 1800;
      enableSshSupport = true;
    };
  };
}
