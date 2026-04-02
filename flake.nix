{
  description = "benkio nix configuration flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    darwin.url = "github:LnL7/nix-darwin";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
  nixConfig = {
    experimental-features = "nix-command flakes";
  };

  outputs = { self, nixpkgs, darwin, home-manager, ... }@inputs:
    let
      # Select host family for which this flake should materialize outputs.
      # Set NIXCFG_HOST=linux (with --impure) for Linux/NixOS outputs.
      isDarwin = builtins.getEnv "NIXCFG_HOST" != "linux";

      darwinSystems =
        if isDarwin then
          import ./flake/hosts/darwin/default.nix {
            inherit inputs;
            system = "aarch64-darwin";
          }
        else
          {};
      nixosSystems =
        if isDarwin then
          {}
        else
          import ./flake/hosts/nixos/default.nix {
            inherit inputs;
            system = "x86_64-linux";
          };
      darwinHomeConfigurations =
        if isDarwin then
          import ./flake/home/darwin.nix {
            inherit inputs;
            system = "aarch64-darwin";
          }
        else
          {};
      nixosHomeConfigurations =
        if isDarwin then
          {}
        else
          import ./flake/home/nixos.nix {
            inherit inputs;
            system = "x86_64-linux";
          };

      selectedNixosOutputs = nixosSystems;
      selectedDarwinOutputs =
        if isDarwin then
          darwinSystems
        else
          {};
      selectedHomeConfigurations =
        if isDarwin then
          darwinHomeConfigurations
        else
          nixosHomeConfigurations;
    in
    {
      darwinConfigurations = selectedDarwinOutputs;
      nixosConfigurations = selectedNixosOutputs;

      homeConfigurations = selectedHomeConfigurations;
    };
}
