{ config, pkgs, ... }:

{

  imports = [
    ./packages.nix
    ./nixConfig.nix
  ];

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
      inherit pkgs;
    };
  };

  environment.pathsToLink = [ "/libexec" ]; # links /libexec from derivations to /run/current-system/sw
  time.timeZone = "Europe/London";

  fonts = {
    packages = with pkgs; [
      proggyfonts
      dejavu_fonts
      nerdfonts
      # corefonts
      ubuntu_font_family
      source-code-pro
      source-sans-pro
      source-serif-pro
    ];
  };

  services = {
    emacs.enable = true; # Emacs daemon
  };
}
