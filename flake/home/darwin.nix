{
  inputs,
  system ? "aarch64-darwin",
}:

let
  stablePackagesOverlay = import ../../systemCommon/stable-packages-overlay.nix inputs;
  pkgs = (inputs.nixpkgs-darwin.legacyPackages.${system}).extend stablePackagesOverlay;
  mkHome = username: homeModule: {
    "${username}" = inputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = {
        inherit inputs;
      };
      modules = [ homeModule ];
    };
  };
in
mkHome "benkio@macos" ../../MacOs/home/home.nix
