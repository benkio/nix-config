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
      JAVA_HOME = "~/.nix-profile/bin/java";
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
        firefox &
        telegram-desktop &
        emacsclient -c &
        alacritty &
      '';
    };
  };
}
