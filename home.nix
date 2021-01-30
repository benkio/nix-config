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
    docker
    ffmpeg
    filezilla
    firefox
    gimp
    gnupg
    hexchat
    htop
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
    pulseaudio #TODO: find out how to do .override { jackaudioSupport = true; }
    qjackctl
    sbt
    scala
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

  programs.emacs = {
    enable = true;
  };

  home.activation.linkEmacsConfig = config.lib.dag.entryAfter [ "emacs" ] ''
    mkdir -p $HOME/.emacs.d
    cp -r ${emacsConfig}/. $HOME/.emacs.d
    chmod -R 777 $HOME/.emacs.d
  '';
  programs.git = {
    enable = true;
    userName = "Enrico Benini";
    userEmail = "benkio89@gmail.com";
  };

  # TODO: Haskell. No haskell platform??
  # TODO: Create workspace folder with all the projects
  # TODO: fstab
  # TODO: i3 & xserver
  # TODO: emacs deamon ??
  # TODO: split/organize into separate files
  
}
