{ config, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    autoconf
    aws-vault
    curl
    docker
    docker-compose
    elmPackages.elm
    elmPackages.elm-format
    eza
    fd
    ffmpeg-full
    ghc
    watchexec
    haskellPackages.hoogle
    # Broken haskellPackages.fix-imports
    html-tidy
    id3v2
    imagemagick
    k9s
    kubectl
    lilypond
    linkchecker
    lsof
    #magic-wormhole
    mcomix3
    mysql
    nix-prefetch-scripts
    nmap
    nodejs
    ntfs3g
    ormolu
    haskellPackages.fourmolu
    stack
    gimp
    ghcid
    haskellPackages.apply-refact
    hlint
    purescript
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
    zip
  ];
}
