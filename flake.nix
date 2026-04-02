{
  description = "benkio nix configuration flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    darwin.url = "github:LnL7/nix-darwin";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, darwin, home-manager, ... }@inputs:
    let
      # Set TARGET_SYSTEM in your environment to force non-darwin outputs (e.g. x86_64-linux).
      detectionSystem = builtins.getEnv "TARGET_SYSTEM";
      targetSystem =
        if detectionSystem == "" then
          "x86_64-darwin"
        else
          detectionSystem;
      isDarwin = builtins.match ".*-darwin$" targetSystem != null;

      darwinSystems =
        if isDarwin then
          import ./flake/hosts/darwin/default.nix {
            inherit inputs;
            system = "x86_64-darwin";
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
            system = "x86_64-darwin";
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

      selectedNixosOutputs =
        if isDarwin then
          {}
        else
          nixosSystems;
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
      nixConfig = {
        experimental-features = "nix-command flakes";
      };

      darwinConfigurations = selectedDarwinOutputs;
      nixosConfigurations = selectedNixosOutputs;

      homeConfigurations = selectedHomeConfigurations;
    };
}
