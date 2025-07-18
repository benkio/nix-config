{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ./packages.nix
    ./programs/programs.nix
    ../../homeCommon/emacsConfig.nix
    ../../homeCommon/bobPaintings.nix
    ../../homeCommon/gists.nix
    ../../homeCommon/packages.nix
    ../../homeCommon/homeConfig.nix
    ../../homeCommon/programs/programs.nix
  ];
  fonts.fontconfig.enable = true;

  services = {
    udiskie.enable = true; # Mount external disks automatically
    gpg-agent = {
      enable = true;
      defaultCacheTtl = 1800;
      enableSshSupport = true;
    };
  };

  gtk = {
    enable = true;
    gtk3 = {
      extraConfig = {
        gtk-recent-files-limit = 20;
      };
      bookmarks = [ "file:///home/benkio/temp temp" ];
    };
  };

  home = {
    sessionVariables = {
      ESHELL = "~/.nix-profile/bin/bash";
    };
  };
}
