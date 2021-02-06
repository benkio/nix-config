{ config, pkgs, ... }:


let
    regolithI3 = pkgs.fetchgit {
      url = "git://github.com/regolith-linux/regolith-i3-gaps-config.git";
      rev = "68a4074fdbc3042398250fc4d23cbd6c990f2ca7";
      sha256 = "070gs8gcr43jpam6bsix5pq3iahzca9z47f0yn2jk7advh8di73k";
    };   
in {
  environment.pathsToLink = [ "/libexec" ]; # links /libexec from derivations to /run/current-system/sw 
  programs.dconf.enable = true;
  
  imports =
    [
      # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
      ];

  boot = {
    loader.grub.enable = true;
    loader.grub.version = 2;
    loader.grub.device = "/dev/sda";
    extraModulePackages = [
      pkgs.linuxPackages.nvidia_x11
    ]; 
  };

  powerManagement.enable = true;
  hardware.opengl.driSupport32Bit = true;
  time.timeZone = "Europe/Rome";
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
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable sound.
  sound = {
    enable = true;
    mediaKeys.enable = true;
  };
  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudioFull; #TODO: find out how to do .override { jackaudioSupport = true; }
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

    xserver = {
      startDbusSession = true;
      enable = true;
      autorun = true;
      layout = "us";
      xkbVariant = "dvp";
      desktopManager = {
        xterm.enable = false;
	gnome3.enable = true;
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
        #configFile = "${regolithI3}/config";
      };
    };
  };

   fonts = {
     enableFontDir = true;
     enableGhostscriptFonts = true;
     fonts = with pkgs; [
       vistafonts
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
    autoconf
    curl
    ffmpeg
    firefox
    gimp
    gparted
    hexchat
    imagemagick
    jack2
    lsof
    nettools
    nmap
    ntfs3g
    parted
    tldr
    unzip
    vlc
    wget
    gcc
    silver-searcher
    xorg.xrandr
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
