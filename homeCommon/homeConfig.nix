{ config, pkgs, lib, ... }:

{
  nixpkgs.config.allowUnfree = true;

  home = {
    homeDirectory = if lib.hasInfix "darwin" builtins.currentSystem then "/Users/benkio" else "/home/benkio";
    keyboard.layout = "us";
    keyboard.variant = "dvp";
    sessionVariables = {
      LANG = "en_US.utf8";
      EDITOR = "emacsclient -t";          # emacs client terminal
      VISUAL = "emacsclient -c -a emacs"; # emacs client visual
      HISTCONTROL = "ignoreboth";
      ESHELL = "/run/current-system/sw/bin/bash";
      SBT_NATIVE_CLIENT = "true";
      PGDATA = "${config.home.homeDirectory}/postgresDataDir";
    };
    stateVersion = "22.11";
    username = "benkio";
    file = {
      ".ghci".text = ''
        :set prompt "\ESC[38;5;208m\STXλ>\ESC[m\STX "

        :def hoogle \s -> return $ ":! hoogle --count=15 \"" ++ s ++ "\""
        -- Better errors
        :set -ferror-spans -freverse-errors -fprint-expanded-synonyms
      '';

      ".xprofile".text = ''
        # Add here different display resolutions using xrandr
        xrandr --output "virtual1" --mode 1920x1200 #Virual Machine resolution

        # Services
        systemctl --user start udiskie.service emacs.service

        # Workaround from here: https://github.com/NixOS/nixpkgs/issues/119513#issuecomment-873506384
        if [ -z $_XPROFILE_SOURCED ]; then
          export _XPROFILE_SOURCED=1

          # Create known directory if doesn't exists
          mkdir -p ${config.home.homeDirectory}/.local/share/applications ${config.home.homeDirectory}/workspace ${config.home.homeDirectory}/temp

          # Startup Programs
          firefox &
          telegram-desktop &
          emacsclient -c &
          alacritty &

        fi
        '';
      ".aspell.conf".text = "data-dir ${config.home.homeDirectory}/.nix-profile/lib/aspell";
    };
  };

  xdg.mimeApps.defaultApplications = {
    "video/x-msvideo" = [ "vlc.desktop" ];
    "video/mp4"       = [ "vlc.desktop" ];
    "audio/mpeg"      = [ "vlc.desktop" ];
    "video/webm"      = [ "vlc.desktop" ];
    "audio/webm"      = [ "vlc.desktop" ];
    "video/mpeg"      = [ "vlc.desktop" ];
    "text/html"       = [ "firefox.desktop" ];
    "application/pdf" = [ "evince.desktop" ];
  };
}
