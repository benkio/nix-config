{ config, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    # elmPackages.elm-format
    # haskellPackages.fix-imports
    # linkchecker
    # mysql
    act
    autoconf
    btop
    curl
    coursier
    docker
    docker-compose
    dust
    elmPackages.elm
    eza
    fd
    ffmpeg-full
    floorp
    ghc
    ghcid
    gimp
    gitui
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
    mcomix
    magic-wormhole
    mediainfo
    mermaid-cli
    mpv
    nix-prefetch-scripts
    nixfmt-rfc-style
    nmap
    nodejs
    ntfs3g
    ormolu
    purescript
    procs
    ripgrep
    rustup
    scala
    scala-cli
    scalafmt
    spark
    sqlite
    stack
    termdown
    tldr
    tunnelto
    unipicker
    unrar
    unzip
    uutils-coreutils
    watchexec
    wget
    xclip
    zip
  ];
}
