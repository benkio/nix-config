{ config, pkgs, lib, ... }:

{
  nixpkgs.config.allowUnfree = true;

  home = {
    keyboard.layout = "us";
    keyboard.variant = "dvp";
    sessionVariables = {
      LANG = "en_US.utf8";
      EDITOR = "emacsclient -t";          # emacs client terminal
      VISUAL = "emacsclient -c -a emacs"; # emacs client visual
      HISTCONTROL = "ignoreboth";
      JAVA_HOME = "/usr/bin/java";
      ESHELL = "/run/current-system/sw/bin/bash";
      SBT_NATIVE_CLIENT = "true";
    };

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

        # Startup Programs
        # Workaround from here: https://github.com/NixOS/nixpkgs/issues/119513#issuecomment-873506384
        if [ -z $_XPROFILE_SOURCED ]; then
          export _XPROFILE_SOURCED=1

          # everything goes here
          firefox &
          telegram-desktop &
          emacsclient -c &
          alacritty &

        fi
        '';
    };
  };
}
