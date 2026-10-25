{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ../../homeCommon/aiSkills.nix
    ../../homeCommon/bobPaintings.nix
    ../../homeCommon/emacsConfig.nix
    ../../homeCommon/gists.nix
    ../../homeCommon/homeConfig.nix
    ../../homeCommon/packages.nix
    ../../homeCommon/programs/floorp.nix
    ../../homeCommon/programs/programs.nix
    ./emacs.nix
    ./packages.nix
    ./programs/programs.nix
    ./sway.nix
    ./xprofile.nix
  ];

  services = {
    udiskie.enable = true; # Mount external disks automatically
    copyq.enable = true; # Clipboard management
    gpg-agent = {
      enable = true;
      defaultCacheTtl = 1800;
      enableSshSupport = true;
    };
    mako = {
      enable = true;
      settings = {
        anchor = "top-right";
        background-color = "#000000";
        border-size = 4;
        border-radius = 4;
        default-timeout = 5000;
        font = "monospace 12";
        ignore-timeout = 1;
        layer = "overlay";
        markup = true;
        max-history = 50;
        max-visible = 10;
        "on-button-left" = "invoke-default-action";
        "on-button-right" = "dismiss";
        "on-touch" = "dismiss";
        sort = "-time";
        width = 500;
      };
      extraConfig = ''
        [urgency=high]
        border-color=#ff5f5f
        default-timeout=0
      '';
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
      "application/pdf" = [ "org.gnome.Evince.desktop" ];
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
