{
  inputs,
  system ? "x86_64-linux",
}:

let
  stablePackagesOverlay = import ../../systemCommon/stable-packages-overlay.nix inputs;
  pkgsWithOverlays = (inputs.nixpkgs.legacyPackages.${system}).extend stablePackagesOverlay;
in
{
  "benkio@nixos" = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = pkgsWithOverlays;
    extraSpecialArgs = {
      inherit inputs;
    };
    modules = [ ../../NixOs/home/home.nix ];
  };
}
