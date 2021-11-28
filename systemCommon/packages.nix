{ config, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    alacritty
    aspell
    autoconf
    awscli2
    bat
    byzanz
    curl
    docker
    docker-compose
    evince
    elmPackages.elm
    elmPackages.elm-format
    fd
    ffmpeg-full
    gcc
    ghc
    haskellPackages.hoogle
    heroku
    imagemagick
    k9s
    klick
    kubectl
    lilypond
    lsof
    ngrok
    nix-index
    nmap
    nodejs
    ntfs3g
    mcomix3
    pandoc
    postgresql
    purescript
    ripgrep
    scala
    scalafmt
    silver-searcher
    (sbt.override { jre = pkgs.jdk11; })
    soulseekqt
    tldr
    unrar
    unzip
    wget
    xclip
    youtube-dl
    zip
  ];
}
