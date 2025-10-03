{ config, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    # elmPackages.elm-format
    # haskellPackages.fix-imports
    # linkchecker
    # mysql
    act                          # Github Action Tester
    autoconf                     # Unix Configuration Scripts
    btop                         # Better htop
    bloop                        # Scala build server and command-line tool
    curl                         # HTTP Requests command
    coursier                     # Scala dependency fetcher
    docker                       # Containers
    docker-compose               # Compose Containers
    dust                         # Better du command
    elmPackages.elm              # Elm programming language
    eza                          # Better ls
    fd                           # Better find
    ffmpeg-full                  # CMD Converter audio/video
    floorp-bin                   # Web Browser firefox-like
    ghc                          # Haskell Compiler
    ghcid                        # Haskell GHCID daemon
    gimp                         # Image Editor
    gitui                        # Git User interface
    haskellPackages.apply-refact # Automatic application of hlint suggestions
    haskellPackages.fourmolu     # Haskell Linter
    haskellPackages.hoogle       # Hoogle search engine
    hlint                        # Haskell Linter
    hurl                         # HTTP Requests in markdown format
    html-tidy                    # HTML formatter
    id3v2                        # ID3v2 Audio tagger
    imagemagick                  # Image converter
    k9s                          # Kubernetes CLI
    kubectl                      # Kubernetes official CLI
    lame                         # Audio Encoder
    lilypond                     # Music Notation Language
    litecli                      # SQLite CLI
    lsof                         # List open files
    mcomix                       # Comix Reader
    magic-wormhole               # File transfer over network
    mediainfo                    # Information about a audio/video file
    mermaid-cli                  # Command Line tool for mermaid
    mpv                          # Video Player
    nix-prefetch-scripts         # Collection of all the nix-prefetch-* scripts
    nixfmt-rfc-style             # Nix Formatter
    nmap                         # Network discovery tool
    nodejs                       # Event-driven I/O framework for JS
    ntfs3g                       # NTFS driver
    ormolu                       # Haskell formatter
    purescript                   # Purescript language
    procs                        # better ps
    ripgrep                      # Better grep
    rustup                       # Rust setup utility
    scala                        # Scala compiler
    scala-cli                    # Scala command line tool
    scalafmt                     # Scala formatting
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
