{ config, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    # elmPackages.elm-format
    # haskellPackages.fix-imports
    # linkchecker
    # mysql
    act
    autoconf
    curl
    docker
    docker-compose
    elmPackages.elm
    eza
    fd
    ffmpeg-full
    ghc
    ghcid
    gimp
    haskellPackages.apply-refact
    haskellPackages.fourmolu
    haskellPackages.hoogle
    hlint
    hurl
    html-tidy
    id3v2
    imagemagick
    k9s
    kubectl
    lame
    lilypond
    litecli
    lsof
    manga-tui
    mcomix
    magic-wormhole
    mediainfo
    nix-prefetch-scripts
    nixfmt-rfc-style
    nmap
    nodejs
    ntfs3g
    ormolu
    purescript
    ripgrep
    rustup
    scala
    scala-cli
    scalafmt
    sqlite
    stack
    termdown
    tldr
    tunnelto
    unipicker
    unrar
    unzip
    watchexec
    wget
    xclip
    zip
  ];
}
