{
  config,
  pkgs,
  lib,
  ...
}:

{
  nixpkgs.config.allowUnfree = true;

  home = {
    homeDirectory =
      if lib.hasInfix "darwin" builtins.currentSystem then "/Users/benkio" else "/home/benkio";
    keyboard.layout = "us";
    keyboard.variant = "dvorak";
    sessionVariables = {
      LANG = "en_US.utf-8";
      EDITOR = "emacsclient -t"; # emacs client terminal
      VISUAL = "emacsclient -c -a emacs"; # emacs client visual
      SBT_NATIVE_CLIENT = "true";
      PGDATA = "${config.home.homeDirectory}/postgresDataDir";
      XDG_CURRENT_DESKTOP = "GNOME"; # To trick some app to work on i3 alone, eg gnome-control-center
    };
    stateVersion = "25.05";
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

        fi
      '';

      # Aspell config
      ".aspell.conf".text = "data-dir ${config.home.homeDirectory}/.nix-profile/lib/aspell";
    };
  };
}
