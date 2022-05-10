{ config, pkgs, lib, ... }:

{
  imports = [
    ../../homeCommon/emacsConfig.nix
    ../../homeCommon/bobPaintings.nix
    ../../homeCommon/homeConfig.nix
    ../../homeCommon/packages.nix
    ../../homeCommon/programs/programs.nix
    ./packages.nix
  ];
  nixpkgs.config.allowUnfree = true;

  home = {
    sessionVariables = {
      LC_ALL="en_US.UTF-8";
      LC_CTYPE="en_US.UTF-8";
    };
    sessionPath = [ "/run/current-system/sw/bin" ];

    activation.copyApplications = let
      apps = pkgs.buildEnv {
        name = "home-manager-applications";
        paths = config.home.packages;
        pathsToLink = "/Applications";
      };
    in lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      baseDir="$HOME/Applications/Home Manager Apps"
      if [ -d "$baseDir" ]; then
        rm -rf "$baseDir"
      fi
      mkdir -p "$baseDir"
      for appFile in ${apps}/Applications/*; do
        target="$baseDir/$(basename "$appFile")"
        $DRY_RUN_CMD cp ''${VERBOSE_ARG:+-v} -fHRL "$appFile" "$baseDir"
        $DRY_RUN_CMD chmod ''${VERBOSE_ARG:+-v} -R +w "$target"
      done
    '';

    activation.postgresFolder = config.lib.dag.entryAfter [ "writeBoundary" ] ''
      if [ ! -d "/Users/benkio/postgresDataDir" ]; then
         mkdir -p "/Users/benkio/postgresDataDir"
         chown -R benkio:staff "/Users/benkio/postgresDataDir"
      fi
      '';
    ## Look at the nixos packages for missing programs. installing them manually unfortunately
  };

}
