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
    # enable = true; conflicts with pipewire
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
  hardware.pulseaudio.enable = false;
  virtualisation.docker.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.benkio = {
    isNormalUser = true;
    extraGroups  = [ "docker" "networkmanager" "wheel" ]; # wheel for ‘sudo’.
    initialHashedPassword = "benkio";
  };

  security.rtkit.enable = true; # Pipewire recommemded
  # Enable the X11 windowing system.
  services = {
    openssh.enable = true;      # Enable the OpenSSH daemon.
    printing.enable = true;     # Enable CUPS to print documents.
    emacs.enable = true;        # Emacs daemon
    blueman.enable = true;      # bluetooth service
    teamviewer.enable = true;   # teamviewer service
    postgresql = {
      enable = true;
      package = pkgs.postgresql;
      authentication = pkgs.lib.mkForce ''
    # Generated file; do not edit!
    # TYPE  DATABASE        USER            ADDRESS                 METHOD
    local   all             all                                     trust
    host    all             all             127.0.0.1/32            trust
    host    all             all             ::1/128                 trust
    '';
    };
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      jack.enable = true;

      # use the example session manager (no others are packaged yet so this is enabled by default,
      # no need to redefine it in your config for now)
      #media-session.enable = true;
      media-session.config.bluez-monitor.rules = [
        {
          # Matches all cards
          matches = [ { "device.name" = "~bluez_card.*"; } ];
          actions = {
            "update-props" = {
              "bluez5.reconnect-profiles" = [ "hfp_hf" "hsp_hs" "a2dp_sink" ];
              # mSBC is not expected to work on all headset + adapter combinations.
              "bluez5.msbc-support" = true;
              # SBC-XQ is not expected to work on all headset + adapter combinations.
              "bluez5.sbc-xq-support" = true;
            };
          };
        }
        {
          matches = [
            # Matches all sources
            { "node.name" = "~bluez_input.*"; }
            # Matches all outputs
            { "node.name" = "~bluez_output.*"; }
          ];
          actions = {
            "node.pause-on-idle" = false;
          };
        }
      ];
    };
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
    pamixer
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
