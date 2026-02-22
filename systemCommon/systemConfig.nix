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

  # PureScript overlay: up-to-date purs, spago, purs-tidy, etc.
  nixpkgs.overlays = [
    (final: prev:
      let
        purescript-overlay-src = builtins.fetchTarball
          "https://github.com/thomashoneyman/purescript-overlay/archive/refs/heads/main.tar.gz";
        purescript-overlay = import (purescript-overlay-src + "/overlay.nix");
      in
        purescript-overlay final prev)
  ];

  environment.pathsToLink = [ "/libexec" ]; # links /libexec from derivations to /run/current-system/sw
  time.timeZone = "Europe/London";

  fonts = {
    packages = with pkgs; [
      corefonts
      dejavu_fonts
      symbola
      iosevka
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
