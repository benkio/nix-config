{ config, pkgs, ... }:


{
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
      inherit pkgs;
    };
  };

  environment.pathsToLink = [ "/libexec" ]; # links /libexec from derivations to /run/current-system/sw
  programs.dconf.enable = true;
  time.timeZone = "Europe/London";
  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;

  imports =
    [
      # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
    ];

  boot.loader = {
    systemd-boot.enable = true;
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
  };

  powerManagement.enable = true;
  hardware.opengl.driSupport32Bit = true;
  networking = {
    networkmanager = { # Enables wireless support and openvpn via network manager.
      enable   = true;
      packages = [ pkgs.networkmanager_openvpn ];
    };

    # The global useDHCP flag is deprecated, therefore explicitly set to false here.
    # Per-interface useDHCP will be mandatory in the future, so this generated config
    # replicates the default behaviour.
    useDHCP = false;
  };

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.utf8";

  # Enable sound.
  sound = {
    enable = true;
    mediaKeys.enable = true;
  };
  hardware.bluetooth = {
    enable = true;
    package = pkgs.bluezFull;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
      };
    };
  };
  hardware.enableRedistributableFirmware = true;
  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudioFull; #TODO: find out how to do .override { jackaudioSupport = true; }
    extraModules = [ pkgs.pulseaudio-modules-bt ];
    extraConfig = ''
      load-module module-echo-cancel

      # null sink
      .ifexists module-null-sink.so
      load-module module-null-sink sink_name=Source
      .endif

      # virtual source
      .ifexists module-virtual-source.so
      load-module module-virtual-source source_name=VirtualMic master=Source.monitor
      .endif

    '';
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.benkio = {
    isNormalUser = true;
    extraGroups  = [ "docker" "networkmanager" "wheel" ]; # wheel for ‘sudo’.
    initialHashedPassword = "benkio";
  };

  # Enable the X11 windowing system.
  services = {
    openssh.enable = true;      # Enable the OpenSSH daemon.
    printing.enable = true;     # Enable CUPS to print documents.
    emacs.enable = true;        # Emacs daemon
    blueman.enable = true;      # bluetooth service
    teamviewer.enable = true;   # teamviewer service

    xserver = {
      enable = true;
      autorun = true;
      layout = "us";
      xkbVariant = "dvp";
      desktopManager = {
        xterm.enable = false;
	      gnome.enable = true;
      };
      displayManager = {
        defaultSession = "none+i3";
        autoLogin = {
          enable = true;
          user = "benkio";
        };
      };

      windowManager.i3 = {
        enable = true;
        package = pkgs.i3-gaps;
        extraPackages = with pkgs; [
          dmenu    # application launcher most people use
          i3status # gives you the default i3 status bar
          i3lock   # default i3 screen locker
        ];
      };
    };
  };

  fonts = {
    fontDir.enable = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      inconsolata
      terminus_font
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
    bluezFull
    curl
    dmenu
    fd
    ffmpeg-full
    flameshot
    firefox
    gcc
    ghc
    glibcLocales
    gimp
    gparted
    hexchat
    i3
    i3lock
    i3status
    imagemagick
    jack2
    lsof
    nettools
    nmap
    ntfs3g
    parted
    pavucontrol
    pulseaudio-ctl
    pulsemixer
    playerctl
    psmisc
    silver-searcher
    ripgrep
    tldr
    unzip
    usbutils
    vlc
    wget
    xorg.xrandr
    brightnessctl
    zip
  ];

  # Nix daemon config
  nix = {
    autoOptimiseStore = true; # Automate `nix-store --optimise`

    gc = {                    # Automate garbage collection
      automatic = true;
      dates     = "weekly";
      options   = "--delete-older-than 7d";
    };

    # Avoid unwanted garbage collection when using nix-direnv
    extraOptions = ''
      keep-outputs     = true
      keep-derivations = true
    '';

    trustedUsers = [ "root" "benkio" ]; # Required by Cachix to be used as non-root user
  };
}
