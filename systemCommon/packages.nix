{ config, pkgs, ... }:

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
    docker                       # Containers
    docker-compose               # Compose Containers
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
    k9s                          # Kubernetes CLI
    kubectl                      # Kubernetes official CLI
    lame                         # Audio Encoder
    lazygit                      # Git User interface
    linkchecker # Link Checker for HTML pages and more
    litecli                      # SQLite CLI
    lsof                         # List open files
    maestral                     # Dropbox alternative
    magic-wormhole               # File transfer over network
    mariadb # Ex-Mysql
    mcomix                       # Comix Reader
    mediainfo                    # Information about a audio/video file
    mermaid-cli                  # Command Line tool for mermaid
    mpv                          # Video Player
    nix-prefetch-scripts         # Collection of all the nix-prefetch-* scripts
    nixfmt-rfc-style             # Nix Formatter
    nmap                         # Network discovery tool
    nodejs                       # Event-driven I/O framework for JS
    ntfs3g                       # NTFS driver
    ormolu                       # Haskell formatter
    postman                      # HTTP Client
    procs                        # better ps
    purescript                   # Purescript language
    ripgrep                      # Better grep
    rustup                       # Rust setup utility
    scala                        # Scala compiler
    scala-cli                    # Scala command line tool
    scalafmt                     # Scala formatter
    sqlite                       # SQLite Database
    stack                        # Haskell Package Manager
    termdown                     # Countdown CLI
    tldr                         # Short Man
    tunnelto                     # Expose local server to the internet
    unipicker                    # Unicode search and select command
    unrar                        # RAR Decompression Command
    unzip                        # ZIP Decompression Command
    uutils-coreutils             # Tools for working with USB
    watchexec                    # Watch files changes command
    wget                         # File downloader from URL
    xclip                        # Clipboard tool
    zip                          # Complession Tool
  ];
}
