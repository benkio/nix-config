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

# TTY settings
  i18n = {
    # luckily this also changes the keyboard layout at boot (for e.g full disk encryption passwords)
    consoleKeyMap = "dvorak-programmer";
  };

  # GUI settings, this includes login screen
  services.xserver.layout = "us";
  services.xserver.xkbVariant = "dvp";
  services.xserver.xkbOptions = "eurosign:e";

  home.sessionVariables = {
    LANG = "en_US.UTF-8";
    EDITOR = "emacs";
  };

  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [  
    ag
    aspell
    audacity
    autoconf
    awscli
    bleachbit
    calibre
    chromium
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
    obs-studio
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
    texlive.combined.scheme-medium
    unrar
    unzip
    vlc
    wget
    youtube-dl
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

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 1800;
    enableSshSupport = true;
  };

  gtk.enable = true;
  xsession = {
    enable = true;
    windowManager.i3.enable = true;
  };
  home.file."xinitrc".text = ''
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
