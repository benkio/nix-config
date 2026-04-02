{
  description = "Darwin flake outputs";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    darwin.url = "github:LnL7/nix-darwin";
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
