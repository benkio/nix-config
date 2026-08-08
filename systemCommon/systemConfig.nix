{
  config,
  pkgs,
  inputs,
  ...
}:

let
  purescript-overlay = import inputs.purescript-overlay;
  pureScriptOverlay = purescript-overlay.overlays.default;
  stablePackagesOverlay = import ./stable-packages-overlay.nix inputs;
in
{

  imports = [
    ./packages.nix
    ./nixConfig.nix
  ];

  nixpkgs.config.allowUnfree = true;

  nixpkgs.overlays = [
    inputs.nur.overlays.default
    pureScriptOverlay
    stablePackagesOverlay
  ];
  environment.pathsToLink = [ "/libexec" ]; # links /libexec from derivations to /run/current-system/sw
  time.timeZone = "Europe/London";

  fonts = {
    packages = with pkgs; [
      corefonts
      dejavu_fonts
      symbola
      iosevka-bin
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
