{ config, pkgs, lib, ... }:

{
  imports = [
    ./i3.nix
    ./firefox.nix
    ./packages.nix
    ./programs/programs.nix
    ../../common/emacsConfig.nix
    ../../common/bobPaintings.nix
  ];
  nixpkgs.config.allowUnfree = true;
  fonts.fontconfig.enable = true;

  home = {
    keyboard.layout = "us";
    keyboard.variant = "dvp";
    sessionVariables = {
      LANG = "en_US.utf8";
      EDITOR = "emacsclient -t";          # emacs client terminal
      VISUAL = "emacsclient -c -a emacs"; # emacs client visual
      HISTCONTROL = "ignoreboth";
      ESHELL = "/run/current-system/sw/bin/bash";
      JAVA_HOME = "~/.nix-profile/bin/java";
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
      '';
    };
  };

  services = {
    udiskie.enable = true;      # Mount external disks automatically
    gpg-agent = {
      enable = true;
      defaultCacheTtl = 1800;
      enableSshSupport = true;
    };
  };
}
