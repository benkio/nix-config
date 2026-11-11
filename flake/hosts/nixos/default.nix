{
  inputs,
  system ? "x86_64-linux",
}:

{
  nixos = inputs.nixpkgs.lib.nixosSystem {
    inherit system;
    specialArgs = {
      inherit inputs;
    };
    modules = [
      inputs.abcde.nixosModules.default
      ../../../NixOs/system/configuration.nix
    ];
  };
}
