{ config, pkgs, lib, ... }:

let
  emacsConfig = pkgs.fetchgit {
    url = "git://github.com/benkio/emacs-config.git";
    rev = "822f696c1c6e89a208d2c6301cf688c4795c17b9";
    sha256 = "1sxqhykkjw0lyriv3pvigzl6qy7985hpncavldp6pqwlkiry72q7";
    leaveDotGit = true;
  };
  bobPaitings = pkgs.fetchgit {
    url = "git://github.com/jwilber/Bob_Ross_Paintings.git";
    rev = "b782b9ec29a847b2d4ba5fe9656396df6a59950f";
    sha256 = "0fs72f2a0q25cyvjjnx0wf1jrmmv7ai5j9389gdybalmwip7f5xk";
  };
in
{
  imports = [
    ./i3.nix
    ./firefox.nix
    ./packages.nix
    ./programs/programs.nix
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
    activation.linkEmacsConfig = config.lib.dag.entryAfter [ "writeBoundary" ] ''
      mkdir -p $HOME/.emacs.d $HOME/.local/share/applications $HOME/workspace
      cp -r -n ${emacsConfig}/. $HOME/.emacs.d
      chmod -R 777 $HOME/.emacs.d
    '';

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
      "wallpapers".source = "${bobPaitings}/data/paintings";
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
