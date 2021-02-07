{ config, pkgs, lib, ... }:

let
   packages = import <nixpkgs> {};
   # TODO: upgrade to the latest in here or do it after
   #       from the emacs folder.
   emacsConfig = packages.fetchgit {
      url = "git://github.com/benkio/emacs-config.git";
      rev = "f4e74803d6cd777d9e95295244784d47e1afc1f1";
      sha256 = "0wqp7y3mnwdw5dm17jha64cvsrrh1qsb702r6a917l573sph563b";
      leaveDotGit = true;
    };

in
{
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
      '';

      ".ghci".text = ''
        :set prompt "λ> "
      '';

      ".xprofile".text = ''
        # Add here different display resolutions using xrandr
        xrandr --output "virtual1" --mode 1920x1200 #Virual Machine resolution

        # Services
        systemctl --user start udiskie.service emacs.service
      '';
    };

    packages = with pkgs; [
            # haskellPackages.hindent marked as broken
      amule      
      audacity
      awscli
      bleachbit
      calibre
      discord
      docker
      filezilla
      ghc
      ghcid
      hlint
      jdk8
      kdeApplications.kdenlive
      lilypond
      nodePackages.npm
      nodePackages.typescript
      nodejs
      pandoc
      postgresql
      purescript
      qjackctl
      sbt
      scala
      slack
      stack
      tdesktop #telegram-desktop
      transmission
      symbola
      unrar
      youtube-dl
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
      #extensions = [
      #  { id = "hfjbmagddngcpeloejdejnfgbamkjaeg"; } # Vimium
      #];
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
