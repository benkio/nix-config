{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    ../../homeCommon/emacsConfig.nix
    ../../homeCommon/gists.nix
    ../../homeCommon/homeConfig.nix
    ../../homeCommon/packages.nix
    ../../homeCommon/programs/bash.nix
    ../../homeCommon/programs/floorp.nix
    ../../homeCommon/programs/programs.nix
    ./packages.nix
    ./work.nix
../../homeCommon/bobPaintings.nix
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
      postgresFolder = config.lib.dag.entryAfter [ "writeBoundary" ] ''
        if [ ! -d "${config.home.homeDirectory}/postgresDataDir" ]; then
           $DRY_RUN_CMD mkdir -p "${config.home.homeDirectory}/postgresDataDir"
           $DRY_RUN_CMD chown -R benkio:staff "${config.home.homeDirectory}/postgresDataDir"
        fi
      '';
      maestralAutostart = config.lib.dag.entryAfter [ "writeBoundary" ] ''
        ${pkgs.maestral}/bin/maestral autostart -Y
        ${pkgs.maestral}/bin/maestral start
      '';
      setAppsDefault = config.lib.dag.entryAfter [ "writeBoundary" ] ''
        echo "set App defaults with duti"
        # Use the Nix-provided duti binary directly to avoid PATH issues
        DUTI="${pkgs.duti}/bin/duti"
        if [ -f "$DUTI" ]; then
          # Try MPV first (preferred)
          if $DUTI -s io.mpv public.mpeg-4 all >/dev/null 2>&1;
          then
            echo "Set MPV for MP4"
            $DUTI -s io.mpv public.movie all 2>/dev/null || true
          # Fall back to VLC if MPV fails
          else
            echo "Set VLC for MP4"
            $DUTI -s org.videolan.vlc public.mpeg-4 all 2>/dev/null || true
            $DUTI -s org.videolan.vlc public.movie all 2>/dev/null || true
          fi
        else
          echo "duti not found at $DUTI"
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

  programs.ssh = {
    matchBlocks = {
      "*" = {
        extraOptions = {
          UseKeychain = "yes";
        };
      };
    };
  };
}
