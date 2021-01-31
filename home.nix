{ config, pkgs, ... }:

let
   packages = import <nixpkgs> {};
   # TODO: upgrade to the latest in here or do it after
   #       from the emacs folder.
   emacsConfig = packages.fetchgit { 
      url = "git://github.com/benkio/emacs-config.git";
      rev = "053ad1ded292bfa049c231d680c1c9530571aa37";
      sha256 = "0643pw2c0wsf45f8diw0yyfqz1vbdbixzjhkgqi4l3bak00zbvjy";
      leaveDotGit = true;
    };
    
in 
{
  programs.home-manager.enable = true;
  # TODO: change those
  home.username = "nix";
  home.homeDirectory = "/home/nix";
  home.stateVersion = "21.03";    

  # GUI settings, this includes login screen
  home.keyboard.layout = "us";
  home.keyboard.variant = "dvp";

  home.sessionVariables = {
    LANG = "en_US.UTF-8";
    EDITOR = "emacs";
  };

  nixpkgs.config.allowUnfree = true;
  fonts.fontconfig.enable = true;
  programs.chromium = {
    enable = true;
    extensions = [
      { id = "hfjbmagddngcpeloejdejnfgbamkjaeg"; } # Vimium  
    ];
  };
  # TODO: programs.firefox.extensions
  home.packages = with pkgs; [  
    ag
    aspell
    audacity
    autoconf
    awscli
    bleachbit
    calibre
    curl
    dejavu_fonts
    discord
    docker
    ffmpeg
    filezilla
    firefox
    gimp
    ghc
    ghcid
    # haskellPackages.hindent marked as broken
    hexchat
    hlint
    imagemagick
    jack2
    lilypond
    nettools
    nodejs
    nodePackages.typescript
    nodePackages.npm
    pandoc
    purescript
    ntfs3g
    jdk8
    postgresql
    pulseaudioFull #TODO: find out how to do .override { jackaudioSupport = true; }
    qjackctl
    sbt
    scala
    slack
    stack
    ghcid
    symbola
    tdesktop #telegra-desktop
    tldr
    transmission
    unrar
    unzip
    vlc
    wget
    youtube-dl
    xorg.xinit
    ];

  programs.emacs.enable = true;
  programs.htop.enable = true;

  home.activation.linkEmacsConfig = config.lib.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p $HOME/.emacs.d
    cp -r -n ${emacsConfig}/. $HOME/.emacs.d
    chmod -R 777 $HOME/.emacs.d
    mkdir -p $HOME/workspace
  '';
  programs.git = {
    enable = true;
    userName = "Enrico Benini";
    userEmail = "benkio89@gmail.com";
  };

  programs.i3status = {
    enable = true;
    enableDefault = true;
  };
 
  programs.obs-studio.enable = true;
  programs.texlive.enable = true;
  programs.zathura.enable = true;
  services.dropbox.enable = true;
  services.udiskie.enable = true;
  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 1800;
    enableSshSupport = true;
  };

  gtk.enable = true;
  xsession = {
    enable = true;
    windowManager.i3.enable = true;
    #TODO: xsession.windowManager.command - Window manager start command. 
  };
  home.file.".xinitrc".text = ''
    if [ -d /etc/X11/xinit/xinitrc.d ]; then
      for f in /etc/X11/xinit/xinitrc.d/*; do
        [ -x "$f" ] && . "$f"
      done
      unset f
    fi

    exec i3
  '';

  # TODO: i3 & xserver
  # TODO: fstab
  # TODO: emacs deamon ??
  # TODO: split/organize into separate files
  
}
