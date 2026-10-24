{
  config,
  pkgs,
  lib,
  ...
}:

let
  user = "benkio";
in
{
  benkio.profile = "personal";

  programs = {
    dconf.enable = true;
    sway = {
      enable = true;
      wrapperFeatures.gtk = true;
      extraPackages = with pkgs; [
        adwaita-icon-theme
      ];
    };
    xwayland.enable = true;
  };
  system = {
    autoUpgrade.enable = true;
    autoUpgrade.allowReboot = false;
    stateVersion = "26.05";
  };

  imports = [
    # Include the results of the hardware scan.
    /etc/nixos/hardware-configuration.nix
    ./packages.nix
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

  systemd = {
    network.wait-online.enable = true;
    enableEmergencyMode = false;
    user.services = {
      kanshi = {
        # To Start Sway
        enable = true;
        description = "kanshi daemon";
        serviceConfig = {
          Type = "simple";
          ExecStart = "${pkgs.kanshi}/bin/kanshi -c kanshi_config_file";
        };
      };
    };
  };

  powerManagement.enable = true;
  powerManagement.powertop.enable = true;

  hardware.graphics.enable32Bit = true;

  networking = {
    networkmanager = {
      # Enables wireless support and openvpn via network manager.
      enable = true;
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
  i18n.defaultLocale = "en_US.UTF-8";

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
  hardware.nvidia.package = pkgs.nvidia_x11;
  virtualisation.docker.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.benkio = {
    isNormalUser = true;
    extraGroups = [
      "docker"
      "networkmanager"
      "wheel"
      "video"
    ]; # wheel for ‘sudo’.
  }
  // lib.optionalAttrs config.benkio.features.enableInsecureBootstrapPassword {
    initialHashedPassword = user;
  };

  security.rtkit.enable = true; # Pipewire recommemded
  # Enable the X11 windowing system.
  services = {
    openssh.enable = true; # Enable the OpenSSH daemon.
    printing.enable = true; # Enable CUPS to print documents.
    blueman.enable = true; # bluetooth service
    gnome.gnome-keyring.enable = true; # Store Wifi passwords
    pulseaudio.enable = false; # Disable Pulseaudio

    logind.settings.Login.HandlePowerKey = "lock"; # Power button behaviour

    mysql = lib.mkIf config.benkio.features.enableLocalDatabases {
      enable = true;
      package = pkgs.mariadb;
      ensureUsers = [
        {
          name = "benkio";
          ensurePermissions = {
            "benkio.*" = "ALL PRIVILEGES";
          };
        }
        {
          name = "root";
          ensurePermissions = {
            "root.*" = "ALL PRIVILEGES";
          };
        }
      ];

    };
    postgresql = lib.mkIf config.benkio.features.enableLocalDatabases (
      {
        enable = true;
        package = (pkgs.postgresql.withPackages (p: [ p.postgis ]));
      }
      // lib.optionalAttrs config.benkio.features.enableTrustAuthForLocalPostgres {
        authentication = pkgs.lib.mkForce ''
          # Generated file; do not edit!
          # TYPE  DATABASE        USER            ADDRESS                 METHOD
          local   all             all                                     trust
          host    all             all             127.0.0.1/32            trust
          host    all             all             ::1/128                 trust
        '';
      }
    );
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # If you want to use JACK applications, uncomment this
      jack.enable = true;
    };
    desktopManager = {
      gnome.enable = true;
    };
    displayManager = {
      defaultSession = "sway";
      gdm.enable = true;
      autoLogin = {
        enable = config.benkio.features.enableAutoLogin;
        user = user;
      };
    };
    picom = {
      enable = true;
      shadow = true;
      shadowOffsets = [
        (-12)
        (-12)
      ];
      shadowOpacity = 0.95;
      fade = true;
    };
  };

  # Nix daemon config
  nix = {
    settings.auto-optimise-store = true; # Automate `nix-store --optimise`
    gc = {
      # Automate garbage collection
      dates = "weekly";
    };
  };
}
