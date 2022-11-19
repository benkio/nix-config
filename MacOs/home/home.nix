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

  targets.darwin.keybindings = {
    "@$M" = "performZoom:";
  };

  home = {
    sessionVariables = {
      LC_ALL="en_US.UTF-8";
      LC_CTYPE="en_US.UTF-8";
    };
    sessionPath = [ "/run/current-system/sw/bin" ];

    activation = {
      copyApplications = let
        apps = pkgs.buildEnv {
          name = "home-manager-applications";
          paths = config.home.packages;
          pathsToLink = "/Applications";
        };
      in lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      baseDir="${config.home.homeDirectory}/Applications/Home Manager Apps"
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
      postgresFolder = config.lib.dag.entryAfter [ "writeBoundary" ] ''
      if [ ! -d "${config.home.homeDirectory}/postgresDataDir" ]; then
         $DRY_RUN_CMD mkdir -p "${config.home.homeDirectory}/postgresDataDir"
         $DRY_RUN_CMD chown -R benkio:staff "${config.home.homeDirectory}/postgresDataDir"
      fi
      '';
    };

    ## Look at the nixos packages for missing programs. installing them using homebrew
    file = {
      "browser.scpt".text =
        ''on run argv
  do shell script "defaultbrowser " & item 1 of argv
  try
    tell application "System Events"
      tell application process "CoreServicesUIAgent"
        tell window 1
          tell (first button whose name starts with "use")
            perform action "AXPress"
          end tell
        end tell
      end tell
    end tell
  end try
end run'';
    };
  };
}
