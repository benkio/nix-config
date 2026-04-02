{ inputs, system ? "x86_64-darwin" }:

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
mkHome "benkio@macos" ../../MacOs/home/home.nix
