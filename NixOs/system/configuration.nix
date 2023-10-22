{ config, pkgs, ... }:


{
  programs.dconf.enable = true;
  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = false;

  imports =
    [
      # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
      ../../systemCommon/systemConfig.nix
    ];

  boot.loader = {
    systemd-boot.enable = true;
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
  };

  boot.supportedFilesystems = [ "ntfs" ];

  fileSystems."/run/media/benkio/externalHD" =
    { device = "dev/sdb1";
      fsType = "ntfs-3g";
      options = [ "rw" "uid=1000" "errors=continue"];
    };
  systemd.enableEmergencyMode = false;

  powerManagement.enable = true;
  hardware.opengl.driSupport32Bit = true;
  networking = {
    networkmanager = { # Enables wireless support and openvpn via network manager.
      enable   = true;
      plugins = [ pkgs.networkmanager-openvpn ];
    };

    # The global useDHCP flag is deprecated, therefore explicitly set to false here.
    # Per-interface useDHCP will be mandatory in the future, so this generated config
    # replicates the default behaviour.
    useDHCP = false;

    firewall = {
      allowedTCPPorts = [ 17500 ];
      allowedUDPPorts = [ 17500 ];
    };
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
    package = pkgs.bluez;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
      };
    };
  };
  hardware.enableRedistributableFirmware = true;
  hardware.pulseaudio.enable = false;
  hardware.nvidia.package = pkgs.nvidia_x11;
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
    blueman.enable = true;      # bluetooth service
    teamviewer.enable = true;   # teamviewer service
    gnome.gnome-keyring.enable = true; # Store Wifi passwords
    postgresql = {
      enable = true;
      package = (pkgs.postgresql.withPackages (p: [ p.postgis ]) );
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
        extraPackages = with pkgs; [
          dmenu    # application launcher most people use
          i3status # gives you the default i3 status bar
          i3lock   # default i3 screen locker
        ];
      };
    };
  };
  systemd.user.services.dropbox = {
    description = "Dropbox";
    wantedBy = [ "graphical-session.target" ];
    environment = {
      QT_PLUGIN_PATH = "/run/current-system/sw/" + pkgs.qt5.qtbase.qtPluginPrefix;
      QML2_IMPORT_PATH = "/run/current-system/sw/" + pkgs.qt5.qtbase.qtQmlPrefix;
    };
    serviceConfig = {
      ExecStart = "${pkgs.dropbox.out}/bin/dropbox";
      ExecReload = "${pkgs.coreutils.out}/bin/kill -HUP $MAINPID";
      KillMode = "control-group"; # upstream recommends process
      Restart = "on-failure";
      PrivateTmp = true;
      ProtectSystem = "full";
      Nice = 10;
    };
  };

  services.logind.extraConfig = ''
    # don’t shutdown when power button is short-pressed
    HandlePowerKey=ignore
  '';

  environment.systemPackages = with pkgs; [
    awscli2
    bluez
    brightnessctl
    byzanz
    copyq
    dmenu
    evince
    exfatprogs
    firefox
    gcc
    glibcLocales
    gnome_mplayer
    gparted
    hexchat
    i3
    i3lock
    i3status
    jack2
    kmetronome
    lshw
    nethogs
    nettools
    pamixer
    parted
    pavucontrol
    pciutils
    playerctl
    psmisc
    soulseekqt
    usbutils
    vlc
    xorg.xrandr
    yt-dlp
  ];

  # Nix daemon config
  nix = {
    settings.auto-optimise-store = true; # Automate `nix-store --optimise`
    gc = {                    # Automate garbage collection
      dates     = "weekly";
    };
  };
}
