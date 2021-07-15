{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
      inherit pkgs;
    };
  };

  environment.pathsToLink = [ "/libexec" ]; # links /libexec from derivations to /run/current-system/sw
  time.timeZone = "Europe/London";

  services = {
    redis.enable = true;

    postgresql = {
      enable = true;
      package = pkgs.postgresql;
    };
  };

  fonts = {
    enableFontDir = true;
    fonts = with pkgs; [
      inconsolata
      proggyfonts
      dejavu_fonts
      font-awesome-ttf
      ubuntu_font_family
      source-code-pro
      source-sans-pro
      source-serif-pro
    ];
  };

  environment.systemPackages = with pkgs; [
    aspell
    alacritty
    autoconf
    curl
    fd
    ffmpeg-full
    gcc
    ghc
    imagemagick
    lsof
    nmap
    ntfs3g
    silver-searcher
    ripgrep
    tldr
    unzip
    wget
    zip
  ];

  # Nix daemon config
  nix = {
    gc = {                    # Automate garbage collection
      automatic = true;
      # dates     = "weekly";
      options   = "--delete-older-than 7d";
    };

    # Avoid unwanted garbage collection when using nix-direnv
    extraOptions = ''
      keep-outputs     = true
      keep-derivations = true
    '';

    trustedUsers = [ "root" "benkio" ]; # Required by Cachix to be used as non-root user
  };


  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
