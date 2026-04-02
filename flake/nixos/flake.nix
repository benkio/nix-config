{
  description = "NixOS flake outputs";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs =
    { inputs, ... }:
    let
      system = "x86_64-linux";
      nixosConfigurations = import ../hosts/nixos/default.nix {
        inherit inputs;
        inherit system;
      };
    in
    {
      nixosConfigurations = nixosConfigurations;
    };
}
