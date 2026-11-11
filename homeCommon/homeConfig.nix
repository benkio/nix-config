{
  config,
  pkgs,
  lib,
  ...
}:

{
  nixpkgs.config.allowUnfree = true;

  fonts.fontconfig.enable = true;

  home = {
    homeDirectory = if pkgs.stdenv.hostPlatform.isDarwin then "/Users/benkio" else "/home/benkio";
    keyboard.layout = "us";
    keyboard.variant = "dvorak";
    sessionVariables = {
      LANG = "en_US.utf-8";
      SBT_NATIVE_CLIENT = "true";
      PGDATA = "${config.home.homeDirectory}/postgresDataDir";
      XDG_CURRENT_DESKTOP = "GNOME"; # To trick some app to work on i3 alone, eg gnome-control-center
    };
    stateVersion = "26.05";
    username = "benkio";
    file = {
      ".ghci".text = ''
        :set prompt "\ESC[38;5;208m\STXλ>\ESC[m\STX "

        :def hoogle \s -> return $ ":! hoogle --count=15 \"" ++ s ++ "\""
        -- Better errors
        :set -ferror-spans -freverse-errors -fprint-expanded-synonyms
      '';

      # Aspell config
      ".aspell.conf".text = "data-dir ${config.home.homeDirectory}/.nix-profile/lib/aspell";
    };
  };
}
