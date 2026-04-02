{
  description = "benkio nix configuration flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    darwin.url = "github:LnL7/nix-darwin";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, darwin, home-manager, ... }@inputs:
    let
      darwinSystems = import ./flake/hosts/darwin/default.nix {
        inherit inputs;
        system = "x86_64-darwin";
      };
      nixosSystems = import ./flake/hosts/nixos/default.nix {
        inherit inputs;
        system = "x86_64-linux";
      };
      darwinHomeConfigurations = import ./flake/home/darwin.nix {
        inherit inputs;
        system = "x86_64-darwin";
      };
      linuxHomeConfigurations = import ./flake/home/linux.nix {
        inherit inputs;
        system = "x86_64-linux";
      };
    in
    {
      nixConfig = {
        experimental-features = "nix-command flakes";
      };

      darwinConfigurations = darwinSystems;
      nixosConfigurations = nixosSystems;

      homeConfigurations =
        darwinHomeConfigurations
        // linuxHomeConfigurations;
    };
}
