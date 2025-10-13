{
  config,
  pkgs,
  lib,
  ...
}:

###############################################################################
#                   Packages without specific configuration                   #
###############################################################################

{
  # Remove linux application, but keeping and merging terminal utilities from nixos system configuration
  home.packages = with pkgs; [
    # BROKEN haskellPackages.ghc-mod
    # BROKEN abcde                        # Audio CD estractor
    act                          # Github Action Tester
    # BROKEN amule                        # P2P Sharing
    autoconf                     # Unix Configuration Scripts
    aws-vault                    # AWS secrets local storage
    bitwarden                    # Password Manager
    bleachbit                    # Linux Cleanup
    bloop                        # Scala build server and command-line tool
    bluez                        # Bluetooth manager
    brightnessctl                # Brightness manager
    btop                         # Better htop
    calibre                      # Book Management (Kindle)
    copyq                        # Clipboard utility
    coursier                     # Scala dependency fetcher
    corefonts                    # Fonts
    curl                         # HTTP Requests command
    dmenu                        # Menu for X Windows Server
    docker                       # Containers
    docker-compose               # Compose Containers
    dust                         # Better du command
    elmPackages.elm              # Elm programming language
    evince                       # PDF Reader
    exfatprogs                   # EXTFat support
    eza                          # Better ls
    fd                           # Better find
    feh                          # Image Viewer
    font-manager                 # Font Manager for GTK
    ffmpeg-full                  # CMD Converter audio/video
    gcc                          # C Compiler
    ghc                          # Haskell Compiler
    ghcid                        # Haskell GHCID daemon
    gitui                        # Git User interface
    glibcLocales                 # Locale information for GNU
    gparted                      # HD Partition
    guvcview                     # Linux Software for managing camera
    #BROKEN haskellPackages.apply-refact # Automatic application of hlint suggestions
    haskellPackages.fourmolu     # Haskell Linter
    haskellPackages.hoogle       # Hoogle search engine
    hexchat                      # IRC Chat
    hlint                        # Haskell Linter
    html-tidy                    # HTML formatter
    hurl                         # HTTP Requests in markdown format
    id3v2                        # ID3v2 Audio tagger
    imagemagick                  # Image converter
    jack2                        # Jack Sound System
    jdk                          # Java Development Kit
    k9s                          # Kubernetes CLI 
    kmetronome                   # Metronome
    kubectl                      # Kubernetes official CLI
    lame                         # Audio Encoder
    kdePackages.kdenlive         # Video Editor
    lilypond                     # Music Notation Language
    litecli                      # SQLite CLI
    lshw                         # Provide Hardware information
    lsof                         # List open files
    lychee                       # Link Checker
    maestral                     # dropbox alternative
    magic-wormhole               # File transfer over network
    mediainfo                    # Information about a audio/video file
    megasync                     # Mega.com Sync
    mermaid-cli                  # Mermaid schema cli
    nethogs                      # Show bandwith by process
    nettools                     # Network CLI tools
    nix-prefetch-scripts         # Nix scripts to obtain bash sources
    nixfmt-rfc-style             # Nix Formatter
    nmap                         # Network discovery tool
    ormolu                       # Haskell formatter
    parted                       # Partition manager
    pavucontrol                  # Pulseaudio Volume Control
    pciutils                     # PCI devices CLI tools
    picard                       # Audio Tagger
    playerctl                    # CLI to control mediaplayers
    procs                        # better ps
    psmisc                       # Processes tools (killall)
    purescript                   # Purescript language
    qjackctl                     # QT Jack Audio Control
    reaper                       # Audio Editor
    ripgrep                      # Better grep
    rustup                       # Rust setup utility
    scala                        # Scala Programming Language
    scala-cli                    # Scala scripting 
    slack                        # Chat
    sqlite                       # SQLite
    stack                        # Haskell Package Manager
    teamviewer                   # Desktop sharing application
    telegram-desktop             # Chat
    termdown                     # Countdown CLI
    tldr                         # Short Man
    tunnelto                     # Expose local server to the internet
    unetbootin                   # Linux/Windows Image Creator
    unipicker                    # Unicode search and select command
    unrar                        # RAR Decompression Command
    unzip                        # ZIP Decompression Command
    usbutils                     # Tools for working with USB
    uutils-coreutils             # Tools for working with USB
    vlc                          # Video Player
    watchexec                    # Watch files changes command
    wget                         # File downloader from URL
    xclip                        # Clipboard tool
    xorg.setxkbmap               # Command to set keybindings
    zip                          # ZIP Compression Command
    zoom-us                      # Video Calls
  ];
}
