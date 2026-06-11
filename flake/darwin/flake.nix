{
  description = "Darwin flake outputs";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    darwin.url = "github:nix-darwin/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs:
    let
      system = "aarch64-darwin";
      darwinConfigurations = import ../hosts/darwin/default.nix {
        inherit inputs;
        inherit system;
      };
    in
    {
      darwinConfigurations = darwinConfigurations;
    };
}
