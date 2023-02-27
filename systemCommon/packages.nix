{ config, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    alacritty
    autoconf
    aws-vault
    bat
    corefonts
    curl
    docker
    docker-compose
    elmPackages.elm
    elmPackages.elm-format
    exa
    fd
    ffmpeg-full
    ghc
    go
    watchexec
    haskellPackages.hoogle
    haskellPackages.fix-imports
    heroku
    html-tidy
    imagemagick
    k9s
    kubectl
    lilypond
    linkchecker
    lsof
    mcomix3
    mysql
    ngrok
    nix-index
    nix-prefetch-scripts
    nmap
    nodejs
    ntfs3g
    jq
    ormolu
    haskellPackages.fourmolu
    stack
    ghcid
    hlint
    pandoc
    purescript
    #(pkgs.callPackage ./revealjs.nix {})
    ripgrep
    rustup
    scala
    scala-cli
    scalafmt
    sqlite
    termdown
    tldr
    tunnelto
    unrar
    unzip
    wget
    xclip
    yt-dlp
    zip
  ];
}
