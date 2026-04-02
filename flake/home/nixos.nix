{ inputs, system ? "x86_64-linux" }:

{
  "benkio@nixos" = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = inputs.nixpkgs.legacyPackages.${system};
    extraSpecialArgs = {
      inherit inputs;
    };
    modules = [ ../../NixOs/home/home.nix ];
  };
}
