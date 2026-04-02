{
  description = "Home Manager configuration flake for CI and local use";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    { inputs, ... }:
    let
      homeNixosConfigurations = import ./nixos.nix {
        inherit inputs;
        system = "x86_64-linux";
      };
      homeDarwinConfigurations = import ./darwin.nix {
        inherit inputs;
        system = "aarch64-darwin";
      };
    in
    {
      homeConfigurations = homeNixosConfigurations // homeDarwinConfigurations;
    };
}
