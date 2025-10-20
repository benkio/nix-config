{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ./sway.nix
    ./packages.nix
    ./programs/programs.nix
    ../../homeCommon/emacsConfig.nix
    ../../homeCommon/bobPaintings.nix
    ../../homeCommon/gists.nix
    ../../homeCommon/packages.nix
    ../../homeCommon/homeConfig.nix
    ../../homeCommon/programs/programs.nix
    ../../homeCommon/programs/floorp.nix
  ];

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
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "application/pdf" = [ "evince.desktop" ];
      "application/x-extension-htm" = "floorp.desktop";
      "application/x-extension-html" = "floorp.desktop";
      "application/x-extension-shtml" = "floorp.desktop";
      "application/x-extension-xht" = "floorp.desktop";
      "application/x-extension-xhtml" = "floorp.desktop";
      "application/xhtml+xml" = "floorp.desktop";
      "audio/mpeg" = [
        "mpv.desktop"
        "vlc.desktop"
      ];
      "audio/webm" = [
        "mpv.desktop"
        "vlc.desktop"
      ];
      "text/html" = [ "floorp.desktop" ];
      "video/mp4" = [
        "mpv.desktop"
        "vlc.desktop"
      ];
      "video/mpeg" = [
        "mpv.desktop"
        "vlc.desktop"
      ];
      "video/webm" = [
        "mpv.desktop"
        "vlc.desktop"
      ];
      "video/x-msvideo" = [
        "mpv.desktop"
        "vlc.desktop"
      ];
      "x-scheme-handler/chrome" = "floorp.desktop";
      "x-scheme-handler/http" = "floorp.desktop";
      "x-scheme-handler/https" = "floorp.desktop";
      "x-scheme-handler/tg" = "org.telegram.desktop.desktop";
      "x-scheme-handler/tonsite" = "org.telegram.desktop.desktop";
    };
  };
}
