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
  allium-cli = pkgs.rustPlatform.buildRustPackage rec {
    pname = "allium-cli";
    version = "3.7.2";
    src = pkgs.fetchCrate {
      inherit pname version;
      hash = "sha256-XUinwaie0WR2Ab9zAB6R0gCVR+1Tn6sehrQpMISczIY=";
    };
    cargoHash = "sha256-kokCayE7BhMmdd+sFVUpK7aKjBZpR4IOQp6oQvyHY0g=";
    doCheck = false; # crate tarball lacks the test fixtures
  };
in
{
  home.packages = with pkgs; [
    allium-cli # Allium spec language CLI
    ariangLauncher # Web UI for aria2 downloads
    aspell # Spelling checker
    aspellDicts.en # Spelling checker Dictionary
    aspellDicts.it # Spelling checker Dictionary
    cabal-install # Haskell package manager
    discord # Chat
    flameshot # Screenshot utility
    picard # Audio Tagger
    prettier # Javascript Formatter
    metals # Scala LSP
    micro # Micro terminal editor
    megacmd # Mega command line tools and sync support
    megatools # Tools to interact with mega.nz
    sops # Encrypted secrets editing
    age # Encryption tool used by sops-nix
    sqlfluff # SQL Linter
    telegram-desktop # Chat
    tsx # Typescript Execute
    typescript # Typescript compiler
    typescript-language-server # Typescript LSP
    zoom-us # Video Calls
    setxkbmap # Command to set keybindings
  ];
}
