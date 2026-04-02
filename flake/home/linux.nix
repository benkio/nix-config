{ inputs, system ? "x86_64-linux" }:

let
  mkHome =
    username:
    homeModule:
    {
      "${username}" = inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = inputs.nixpkgs.legacyPackages.${system};
        extraSpecialArgs = {
          inherit inputs;
        };
        modules = [ homeModule ];
      };
    };
in
mkHome "benkio@nixos" ../../NixOs/home/home.nix
// mkHome "benkio@wsl2" ../../wsl2/home/home.nix
