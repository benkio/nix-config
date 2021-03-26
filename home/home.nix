{ config, pkgs, lib, ... }:

let
   # TODO: upgrade to the latest in here or do it after
   #       from the emacs folder.
   emacsConfig = pkgs.fetchgit {
      url = "git://github.com/benkio/emacs-config.git";
      rev = "f4e74803d6cd777d9e95295244784d47e1afc1f1";
      sha256 = "1sjky33xks94aw3zkbl82spn3jz8bjyj8fb6fsm6c8kncm7qgbd7";
      leaveDotGit = true;
    };
   bobPaitings = pkgs.fetchgit {
      url = "git://github.com/jwilber/Bob_Ross_Paintings.git";
      rev = "b782b9ec29a847b2d4ba5fe9656396df6a59950f";
      sha256 = "0fs72f2a0q25cyvjjnx0wf1jrmmv7ai5j9389gdybalmwip7f5xk";
    };    
in
{
  imports = [./i3.nix ./firefox.nix];
  nixpkgs.config.allowUnfree = true;
  fonts.fontconfig.enable = true;

  home = {
    keyboard.layout = "us";
    keyboard.variant = "dvp";
    sessionVariables = {
      LANG = "en_US.utf8";
      EDITOR = "emacsclient -t";          # emacs client terminal
      VISUAL = "emacsclient -c -a emacs"; # emacs client visual
    };
    activation.linkEmacsConfig = config.lib.dag.entryAfter [ "writeBoundary" ] ''
      mkdir -p $HOME/.emacs.d $HOME/.local/share/applications $HOME/workspace
      cp -r -n ${emacsConfig}/. $HOME/.emacs.d
      chmod -R 777 $HOME/.emacs.d
    '';

    file = {
      ".bashrc".text = ''
        cp -f ~/.nix-profile/share/applications/*.desktop ~/.local/share/applications/

        shopt -s autocd #Automatically put `cd` before a path
        export HISTCONTROL=ignoreboth
        export XDG_DATA_DIRS=~/.local/share/:~/.nix-profile/share:/usr/share
        export PATH=$PATH:~/.local/bin
        alias sbt="sbt -Dsbt.supershell=false"
      '';

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

    packages = with pkgs; [
      awscli
      bitwarden
      bleachbit
      calibre
      deluge
      discord
      docker
      elmPackages.elm
      elmPackages.elm-format
      feh
      filezilla
      ghc
      ghcid
      hlint
      jdk8
      kdeApplications.kdenlive
      lilypond
      haskellPackages.hoogle
      # BROKEN haskellPackages.ghc-mod 
      nodePackages.npm
      nodePackages.typescript
      nodejs
      nix-index
      ormolu
      pandoc
      postgresql
      purescript
      qjackctl
      reaper
      sbt
      scala
      slack
      sound-juicer
      soulseekqt
      stack
      symbola
      tdesktop #telegram-desktop
      teamviewer
      unetbootin
      unrar
      youtube-dl
      amule
    ];
  };

  programs = {
    emacs.enable = true;
    htop.enable = true;
    obs-studio.enable = true;
    texlive.enable = true;
    zathura.enable = true;
    home-manager.enable = true;
    chromium = {
      enable = true;
      extensions = [
        "dbepggeogbaibhgnhhndojpepiihcmeb" # Vimium
        "nngceckbapebfimnlniiiahkandclblb" # LastPass
        "gighmmpiobklfepjocnamgkkbiglidom" # AdBlock
      ];
    };
    git = {
      enable = true;
      userName = "Enrico Benini";
      userEmail = "benkio89@gmail.com";
    };
    bash = {
      enable = true;
      initExtra = ''
        . $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh
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

  # TODO: split/organize into separate files

}
