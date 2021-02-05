{ config, pkgs, ... }:

let
  user = "benkio";
  userHome = "/home/${user}";
  hostName = "benkio-laptop";

  home-manager = { home-manager-path, config-path }:
    assert builtins.typeOf home-manager-path == "string";
    assert builtins.typeOf config-path == "string";
    (
      pkgs.callPackage
        (/. + home-manager-path + "/home-manager") { path = "${home-manager-path}"; }
    ).overrideAttrs (old: {
      nativeBuildInputs = [ pkgs.makeWrapper ];
      buildCommand =
        let
          home-mananger-bootstrap = pkgs.writeTextFile {
            name = "home-manager-bootstrap.nix";
            text = ''
              { config, pkgs, ... }:
              {
                # Home Manager needs a bit of information about you and the
                # paths it should manage.
                home.username = "${user}";
                home.homeDirectory = "${userHome}";
                home.sessionVariables.HOSTNAME = "${hostName}";
                imports = [ ${config-path} ];
              }
            '';
          }; in
        ''
          ${old.buildCommand}
          wrapProgram $out/bin/home-manager --set HOME_MANAGER_CONFIG "${home-mananger-bootstrap}"
        '';
    });
in
{
  users.users.${user} = {
    home = userHome;
    packages = [
      (home-manager {
        home-manager-path = "${userHome}/home-manager";
        config-path = builtins.toString ../home-manager + "/${hostName}.nix";
      })
    ];
    isNormalUser = true;
    extraGroups  = [ "docker" "networkmanager" "wheel" ]; # wheel for ‘sudo’.
  };

  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ];

  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda";

  # Set your time zone.
  # time.timeZone = "Europe/Rome";
    networking = {
    # Enables wireless support and openvpn via network manager.
    networkmanager = {
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

  # Enable the X11 windowing system.
  services = {
    # Enable the OpenSSH daemon.
    openssh.enable = true;

    # Enable CUPS to print documents.
    printing.enable = true;
    
    xserver = {
    enable = true;
    desktopManager = {
      xterm.enable = false;
      xfce.enable = true;
    };
    displayManager.defaultSession = "xfce";
  };

  };

  # Nix daemon config
  nix = {
    # Automate `nix-store --optimise`
    autoOptimiseStore = true;

    # Automate garbage collection
    gc = {
      automatic = true;
      dates     = "weekly";
      options   = "--delete-older-than 7d";
    };

    # Avoid unwanted garbage collection when using nix-direnv
    extraOptions = ''
      keep-outputs     = true
      keep-derivations = true
    '';

    # Required by Cachix to be used as non-root user
    trustedUsers = [ "root" "benkio" ];
  };

}
