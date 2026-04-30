{ config, pkgs, ... }:

{
  nix = {
    gc = {
      # Automate garbage collection
      automatic = true;
      options = "--delete-older-than 7d";
    };

    settings = {
      max-jobs = 2;
      cores = 2;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
    # trusted-users = [ "root" "benkio" ]; # Required by Cachix to be used as non-root user
  };
}
