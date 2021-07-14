{ config, pkgs, lib, ... }:

###############################################################################
#                   Packages without specific configuration                   #
###############################################################################

{
  home.packages = with pkgs; [
    (sbt.override { jre = pkgs.jdk11; })
    amule
    awscli
    bitwarden
    bleachbit
    calibre
    discord
    direnv
    docker
    docker-compose
    elmPackages.elm
    elmPackages.elm-format
    feh
    filezilla
    ghc
    ghcid
    haskellPackages.hoogle
    hlint
    jdk11
    libsForQt5.kdenlive
    lilypond
    nix-index
    nodePackages.js-beautify
    nodePackages.npm
    nodePackages.typescript
    nodejs
    ormolu
    pandoc
    purescript
    qjackctl
    reaper
    scala
    scalafmt
    slack
    soulseekqt
    sound-juicer
    stack
    symbola
    tdesktop #telegram-desktop
    teamviewer
    tixati
    unetbootin
    unrar
    youtube-dl
    xclip
    zoom-us
    # BROKEN haskellPackages.ghc-mod
  ];
}
