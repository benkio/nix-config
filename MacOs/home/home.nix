{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ../../homeCommon/emacsConfig.nix
    ../../homeCommon/bobPaintings.nix
    ../../homeCommon/gists.nix
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
      LC_ALL = "en_US.UTF-8";
      LC_CTYPE = "en_US.UTF-8";
      SHELL = "/run/current-system/sw/bin/bash";
      ESHELL = "/run/current-system/sw/bin/bash";
    };
    sessionPath = [
      "/run/current-system/sw/bin"
      "/usr/local/bin"
    ];

    activation = {
      # https://github.com/nix-community/home-manager/issues/1341#issuecomment-1716147796
      trampolineApps =
        let
          apps = pkgs.buildEnv {
            name = "home-manager-applications";
            paths = config.home.packages;
            pathsToLink = "/Applications";
          };
        in
        lib.hm.dag.entryAfter [ "writeBoundary" ] ''
          toDir="$HOME/Applications/HMApps"
          fromDir="${apps}/Applications"
          rm -rf "$toDir"
          mkdir "$toDir"
          (
            cd "$fromDir"
            for app in *.app; do
              /usr/bin/osacompile -o "$toDir/$app" -e "do shell script \"open '$fromDir/$app'\""
              icon="$(/usr/bin/plutil -extract CFBundleIconFile raw "$fromDir/$app/Contents/Info.plist")"
              if [[ $icon != *".icns" ]]; then
                icon="$icon.icns"
              fi
              mkdir -p "$toDir/$app/Contents/Resources"
              cp -f "$fromDir/$app/Contents/Resources/$icon" "$toDir/$app/Contents/Resources/applet.icns"
            done
          )
        '';
      postgresFolder = config.lib.dag.entryAfter [ "writeBoundary" ] ''
        if [ ! -d "${config.home.homeDirectory}/postgresDataDir" ]; then
           $DRY_RUN_CMD mkdir -p "${config.home.homeDirectory}/postgresDataDir"
           $DRY_RUN_CMD chown -R benkio:staff "${config.home.homeDirectory}/postgresDataDir"
        fi
      '';
    };

    # Look at the nixos packages for missing programs. installing them using homebrew
    file = {
      "browser.scpt".text = ''
        on run argv
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
