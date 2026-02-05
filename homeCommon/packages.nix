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
    aspell                                  # Spelling checker
    aspellDicts.en                          # Spelling checker Dictionary
    aspellDicts.en-computers                # Spelling checker Dictionary
    aspellDicts.en-science                  # Spelling checker Dictionary
    aspellDicts.it                          # Spelling checker Dictionary
    cabal-install                           # Haskell package manager
    discord                                 # Chat
    flameshot                               # Screenshot utilityy
    losslesscut-bin                         # Gui for FFMPEG
    nodePackages.aws-cdk                    # AWS Cloud Development Kit
    nodePackages.js-beautify                # Javascript beautifier
    nodePackages.npm                        # Node package manager
    nodePackages.prettier                   # Javascript Formatter
    nodePackages.purescript-language-server # Purescript LSP
    nodePackages.yarn                       # Package manager
    metals                                  # Scala LSP
    sqlfluff                                # SQL Linter
    symbola                                 # Font
    tex                                     # Typesetting Engine
    tsx                                     # Typescript Execute
    typescript                              # Typescript compiler
    typescript-language-server              # Typescript LSP
    xorg.setxkbmap                          # Command to set keybindings
    zed-editor                              # Alternative editor
  ];
}
