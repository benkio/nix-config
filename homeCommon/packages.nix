{
  config,
  pkgs,
  lib,
  ...
}:

###############################################################################
#                   Packages without specific configuration                   #
###############################################################################
let
  tex = (pkgs.texlive.combine { #from https://nixos.wiki/wiki/TexLive#Combine_Sets
    inherit (pkgs.texlive) scheme-full
      dvisvgm dvipng # for preview and export as html
      wrapfig amsmath ulem hyperref capt-of;
      #(setq org-latex-compiler "lualatex")
      #(setq org-preview-latex-default-process 'dvisvgm)
  });
in
{
  home.packages = with pkgs; [
    # BROKEN handbrake
    aspell
    aspellDicts.en
    aspellDicts.en-science
    aspellDicts.en-computers
    aspellDicts.it
    cabal-install
    discord
    nodePackages.js-beautify
    nodePackages.npm
    nodePackages.jsonlint
    nodePackages.typescript
    nodePackages.typescript-language-server
    nodePackages.yarn
    nodePackages.prettier
    nodePackages.aws-cdk
    sqlfluff
    tex
    symbola
    xorg.setxkbmap
  ];
}
