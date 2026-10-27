{
  inputs,
  system ? "aarch64-darwin",
}:

{
  macos = inputs.darwin.lib.darwinSystem {
    inherit system;
    specialArgs = {
      inherit inputs;
    };
    modules = [
      inputs.sops-nix.darwinModules.sops
      ../../../MacOs/system/darwin-configuration.nix
    ];
  };
}
