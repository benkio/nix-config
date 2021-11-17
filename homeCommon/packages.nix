{ config, pkgs, lib, ... }:

###############################################################################
#                   Packages without specific configuration                   #
###############################################################################

{
  home.packages = with pkgs; [
      awscli2
      direnv
      docker
      docker-compose
      elmPackages.elm
      elmPackages.elm-format
      ghc
      ghcid
      handbrake
      haskellPackages.hoogle
      heroku
      hlint
      kubectl
      k9s
      lilypond
      nix-index
      nodePackages.js-beautify
      nodePackages.npm
      nodePackages.typescript
      nodejs
      ormolu
      pandoc
      postgresql
      purescript
      scala
      scalafmt
      stack
      symbola
      unrar
      xclip
      youtube-dl
      (sbt.override { jre = pkgs.jdk11; })
    ];
}
