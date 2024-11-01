{ config, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    act
    autoconf
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
    # haskellPackages.fix-imports
    html-tidy
    id3v2
    imagemagick
    lame
    k9s
    kubectl
    lilypond
    # linkchecker
    lsof
    magic-wormhole
    mediainfo
    # mcomix3
    # mysql
    nix-prefetch-scripts
    nixfmt-rfc-style
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
    unipicker
    wget
    xclip
    zip
  ];
}
