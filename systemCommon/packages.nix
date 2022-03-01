{ config, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    alacritty
    aspell
    autoconf
    awscli2
    bat
    curl
    docker
    docker-compose
    elmPackages.elm
    elmPackages.elm-format
    fd
    ffmpeg-full
    haskellPackages.fswatcher
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
    nix-prefetch-scripts
    nmap
    nodejs
    ntfs3g
    mcomix3
    pandoc
    purescript
    ripgrep
    scala
    scala-cli
    scalafmt
    (sbt.override { jre = pkgs.jdk11; })
    tldr
    termdown
    tunnelto
    unrar
    unzip
    wget
    xclip
    yt-dlp
    zip
  ];
}
