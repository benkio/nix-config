{
  config,
  pkgs,
  lib,
  ...
}:

###############################################################################
#                   Packages without specific configuration                   #
###############################################################################
# let
#   tex = (
#     pkgs.texlive.combine {
#       # from https://nixos.wiki/wiki/TexLive#Combine_Sets
#       inherit (pkgs.texlive)
#         scheme-full
#         dvisvgm
#         dvipng # for preview and export as html
#         wrapfig
#         amsmath
#         ulem
#         hyperref
#         capt-of
#         ;
#       #(setq org-latex-compiler "lualatex")
#       #(setq org-preview-latex-default-process 'dvisvgm)
#     }
#   );
# in
let
  ariangLauncher =
    if pkgs.stdenv.hostPlatform.isDarwin then
      (pkgs.writeShellScriptBin "ariang" ''
        set -euo pipefail
        src_dir="${pkgs.ariang}/share/ariang"
        cache_dir="$HOME/.cache/ariang"

        mkdir -p "$cache_dir"
        cp -R "$src_dir"/. "$cache_dir"/

        exec open "$cache_dir/index.html"
      '')
    else
      pkgs.ariang;
in
{
  home.packages = with pkgs; [
    # BROKEN handbrake
    ariangLauncher # Web UI for aria2 downloads
    aspell # Spelling checker
    aspellDicts.en # Spelling checker Dictionary
    aspellDicts.en-computers # Spelling checker Dictionary
    aspellDicts.en-science # Spelling checker Dictionary
    aspellDicts.it # Spelling checker Dictionary
    cabal-install # Haskell package manager
    discord # Chat
    flameshot # Screenshot utilityy
    picard # Audio Tagger
    prettier # Javascript Formatter
    metals # Scala LSP
    micro # Micro terminal editor
    megacmd # Mega command line tools and sync support
    megatools # Tools to interact with mega.nz
    sqlfluff # SQL Linter
    telegram-desktop # Chat
    # tex # Typesetting Engine
    tsx # Typescript Execute
    typescript # Typescript compiler
    typescript-language-server # Typescript LSP
    zoom-us # Video Calls
    setxkbmap # Command to set keybindings
  ];
}
