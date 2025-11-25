{ config, pkgs, ... }:

let
    mastralOldPkgs = import (builtins.fetchTarball {
        url = "https://github.com/NixOS/nixpkgs/archive/05bbf675397d5366259409139039af8077d695ce.tar.gz";
    }) {};

    maestralOld = mastralOldPkgs.maestral;
in
{

  environment.systemPackages = with pkgs; [
    # haskellPackages.fix-imports
    # haskellPackages.apply-refact # Automatic application of hlint suggestions
    act                          # Github Action Tester
    autoconf                     # Unix Configuration Scripts
    bloop                        # Scala build server and command-line tool
    btop                         # Better htop
    coursier                     # Scala dependency fetcher
    curl                         # HTTP Requests command
    cpulimit                     # Tool to limit CPU usage from a program, PID, Command
    dust                         # Better du command
    elmPackages.elm              # Elm programming language
    elmPackages.elm-format       # Elm formatter
    eza                          # Better ls
    fd                           # Better find
    ffmpeg-full                  # CMD Converter audio/video
    fontconfig                   # Utilities for dealing with fonts
    ghc                          # Haskell Compiler
    ghcid                        # Haskell GHCID daemon
    gnupg1                       # Used to sign commits
    haskellPackages.fourmolu     # Haskell Linter
    haskellPackages.hoogle       # Hoogle search engine
    hlint                        # Haskell Linter
    html-tidy                    # HTML formatter
    hurl                         # HTTP Requests in markdown format
    id3v2                        # ID3v2 Audio tagger
    imagemagick                  # Image converter
    jdk                          # Java Development Kit
    k9s                          # Kubernetes CLI
    kubectl                      # Kubernetes official CLI
    lame                         # Audio Encoder
    lazygit                      # Git User interface
    linkchecker # Link Checker for HTML pages and more
    litecli                      # SQLite CLI
    lsof                         # List open files
    maestralOld                  # Dropbox alternative
    magic-wormhole               # File transfer over network
    mariadb                      # Ex-Mysql
    mediainfo                    # Information about a audio/video file
    mermaid-cli                  # Command line tool for mermaid
    moreutils                    # More command line tools
    mpv                          # Video Player
    # mycli                        # Command line tool for mysql
    nix-prefetch-scripts         # Collection of all the nix-prefetch-* scripts
    nixfmt-rfc-style             # Nix Formatter
    nmap                         # Network discovery tool
    nodejs                       # Event-driven I/O framework for JS
    ntfs3g                       # NTFS driver
    ormolu                       # Haskell formatter
    procs                        # better ps
    purescript                   # Purescript language
    ripgrep                      # Better grep
    rustup                       # Rust setup utility
    scala                        # Scala compiler
    scala-cli                    # Scala command line tool
    scalafmt                     # Scala formatter
    sd                           # Modern Sed
    sqlite                       # SQLite Database
    stack                        # Haskell Package Manager
    termdown                     # Countdown CLI
    tldr                         # Short Man
    tree                         # Print the filesystem on terminal
    tunnelto                     # Expose local server to the internet
    unipicker                    # Unicode search and select command
    unrar                        # RAR Decompression Command
    unzip                        # ZIP Decompression Command
    uutils-coreutils             # Tools for working with USB
    watchexec                    # Watch files changes command
    wget                         # File downloader from URL
    xclip                        # Clipboard tool
    zed-editor                   # Alternative editor
    zip                          # Complession Tool
  ];
}
