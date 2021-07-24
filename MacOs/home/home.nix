{ config, pkgs, lib, ... }:

{
  imports = [
    ../../common/emacsConfig.nix
    ../../common/bobPaintings.nix
    ../../common/homeConfig.nix
    ../../common/packages.nix
    ../../common/programs/programs.nix
  ];
  nixpkgs.config.allowUnfree = true;

  home = {
    sessionVariables = {
      LC_ALL="en_US.UTF-8";
      LC_CTYPE="en_US.UTF-8";
      NIX_PATH = "darwin-config=$HOME/.nixpkgs/darwin-configuration.nix:$NIX_PATH";
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
  };

}
