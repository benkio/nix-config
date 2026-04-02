{ inputs, system ? "x86_64-linux" }:

let
  mkHost =
    name:
    modules:
    {
      ${name} = inputs.nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit inputs;
        };
        modules = modules;
      };
    };
in
mkHost "nixos" [
  ../../../NixOs/system/configuration.nix
]
// mkHost "wsl2" [
  ../../../NixOs/system/configuration.nix
  {
    networking.hostName = "wsl2";
  }
]
