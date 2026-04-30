{ config, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    # haskellPackages.fix-imports
    # haskellPackages.apply-refact # Automatic application of hlint suggestions
    act # Github Action Tester
    autoconf # Unix Configuration Scripts
    bloop # Scala build server and command-line tool
    bruno # Bruno HTTP Client - Postman Alternative
    bruno-cli # Bruno CLI
    btop # Better htop
    cdrtools # Highly portable CD/DVD/BluRay command line recording software
    coreutils # GNU Core Utilities
    coursier # Scala dependency fetcher
    cpulimit # Tool to limit CPU usage from a program, PID, Command
    curl # HTTP Requests command
    docker # Docker CLI
    docker-compose # Compose Containers
    dust # Better du command
    elmPackages.elm # Elm programming language
    elmPackages.elm-format # Elm formatter
    esbuild # Javascript Bundler
    eza # Better ls
    fd # Better find
    ffmpeg-full # CMD Converter audio/video
    fontconfig # Utilities for dealing with fonts
    ghc # Haskell Compiler
    ghcid # Haskell GHCID daemon
    gnupg1 # Used to sign commits
    gnused # GNU SED Command
    google-java-format # Google Java formatter
    gradle # Build Tool
    haskellPackages.fourmolu # Haskell Linter
    haskellPackages.hoogle # Hoogle search engine
    hlint # Haskell Linter
    html-tidy # HTML formatter
    hurl # HTTP Requests in markdown format
    id3v2 # ID3v2 Audio tagger
    imagemagick # Image converter
    jdk # Java Development Kit
    k9s # Kubernetes CLI
    kubectl # Kubernetes official CLI
    kubectx # Fast way to switch between clusters and namespaces in kubectl
    lame # Audio Encoder
    lazygit # Git User interface
    linkchecker # Link Checker for HTML pages and more
    lsof # List open files
    lychee # Link Checker
    maestral # Dropbox alternative
    magic-wormhole # File transfer over network
    mariadb # Ex-MySQL
    mediainfo # Information about a audio/video file
    mermaid-cli # Command line tool for mermaid
    moreutils # More command line tools
    nix-prefetch-scripts # Collection of all the nix-prefetch-* scripts
    nixfmt # Nix Formatter
    nmap # Network discovery tool
    nodejs # Event-driven I/O framework for JS
    ntfs3g # NTFS driver
    ormolu # Haskell formatter
    pkg-config # Queries information about libraries
    procs # better ps
    progress # Tool that shows the progress of coreutils programs
    purs # PureScript compiler (from purescript-overlay)
    purs-tidy # Purescript Formatter
    python313Packages.eyed3 # ID3 tagger - abcde hidden dependency
    ripgrep # Better grep
    rustup # Rust setup utility
    scala # Scala compiler
    scala-cli # Scala command line tool
    scalafmt # Scala formatter
    sd # Modern Sed
    spago # PureScript package manager (from purescript-overlay)
    sqlite # SQLite Database
    stack # Haskell Package Manager
    termdown # Countdown CLI
    tldr # Short Man
    tree # Print the filesystem on terminal
    tunnelto # Expose local server to the internet
    unipicker # Unicode search and select command
    unrar # RAR Decompression Command
    unzip # ZIP Decompression Command
    usql # SQL CLI client
    uutils-coreutils # Tools for working with USB
    watchexec # Watch files changes command
    wget # File downloader from URL
    xclip # Clipboard tool
    zip # Complession Tool
    zoxide # Better cd command
  ];
}
