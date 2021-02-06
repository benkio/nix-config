{ config, pkgs, ... }:


let
    regolithI3 = pkgs.fetchgit {
      url = "git://github.com/regolith-linux/regolith-i3-gaps-config.git";
      rev = "68a4074fdbc3042398250fc4d23cbd6c990f2ca7";
      sha256 = "0wqp7y3mnwdw5dm17jha64cvsrrh1qsb702r6a917l573sph563b";
    };   
in {
  nixpkgs.config.allowUnfree = true;
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
  
  };

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
  hardware.pulseaudio.enable = true;

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
      enable = true;
      layout = "us";
      xkbVariant = "dvp";
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
        configFile = "${regolithI3}/config";
      };
    };
  };

   fonts.fonts = with pkgs; [
      symbola
      dejavu_fonts
  ];

  environment.systemPackages = with pkgs; [
    aspell
    autoconf
    curl
    wget
    pulseaudioFull #TODO: find out how to do .override { jackaudioSupport = true; }
    unrar
    unzip
    vlc
    tldr
    ntfs3g
    nettools
    imagemagick
    jack2
    firefox
    ffmpeg
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
