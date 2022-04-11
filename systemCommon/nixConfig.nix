{ config, pkgs, ... }:


{
  nix = {
    gc = {                    # Automate garbage collection
      automatic = true;
      options   = "--delete-older-than 7d";
    };

    # Avoid unwanted garbage collection when using nix-direnv
    extraOptions = ''
      keep-outputs     = true
      keep-derivations = true
    '';
    trustedUsers = [ "root" "benkio" ]; # Required by Cachix to be used as non-root user
  };
}
