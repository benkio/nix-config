{
  description = "benkio nix configuration flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    darwin.url = "github:LnL7/nix-darwin";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
  nixConfig = {
    experimental-features = "nix-command flakes";
  };

  outputs =
    {
      ...
    }@inputs:
    let
      nixosFlake = (import ./flake/nixos/flake.nix).outputs inputs;
      darwinFlake = (import ./flake/darwin/flake.nix).outputs inputs;
      homeFlake = (import ./flake/home/flake.nix).outputs inputs;
    in
    {
      nixosConfigurations = nixosFlake.nixosConfigurations;
      darwinConfigurations = darwinFlake.darwinConfigurations;
      homeConfigurations = homeFlake.homeConfigurations;
    };
}
