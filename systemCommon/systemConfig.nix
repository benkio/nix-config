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

  system.primaryUser = "benkio";
  environment.pathsToLink = [ "/libexec" ]; # links /libexec from derivations to /run/current-system/sw
  time.timeZone = "Europe/London";

  fonts = {
    packages = with pkgs; [
      dejavu_fonts
      nerd-fonts.dejavu-sans-mono
      nerd-fonts.jetbrains-mono
      nerd-fonts.proggy-clean-tt
      nerd-fonts.sauce-code-pro
      nerd-fonts.ubuntu
      nerd-fonts.ubuntu-mono
      nerd-fonts.ubuntu-sans
    ];
  };

  services = {
    emacs.enable = true; # Emacs daemon
  };
}
