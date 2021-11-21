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
    kubectl
    lilypond
    lsof
    ngrok
    nix-index
    nmap
    nodejs
    ntfs3g
    pandoc
    postgresql
    purescript
    ripgrep
    scala
    scalafmt
    silver-searcher
    (sbt.override { jre = pkgs.jdk11; })
    tldr
    unrar
    unzip
    wget
    xclip
    youtube-dl
    zip
  ];
}
