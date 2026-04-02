{ config, pkgs, ... }:

let
  home = "/Users/${config.system.primaryUser}";
in
{
  imports = [
    ../../systemCommon/systemConfig.nix
    ./homebrew.nix
    ./programs.nix
    ./services.nix
    ./work.nix
    ./ollama-models.nix
  ];

  system.primaryUser = "benkio";

  launchd.user.agents = {
    postgresql.serviceConfig = {
      StandardErrorPath = "${home}/postgres.error.log";
      StandardOutPath = "${home}/postgres.log";
    };

    ollama = {
      serviceConfig = {
        ProgramArguments = [
          "${pkgs.ollama}/bin/ollama"
          "serve"
        ];
        RunAtLoad = true;
        KeepAlive = true;
        StandardErrorPath = "${home}/ollama.error.log";
        StandardOutPath = "${home}/ollama.log";
      };
    };
    bobPaintings = {
      serviceConfig = {
        ProgramArguments = [
          "${pkgs.bash}/bin/bash"
          "-lc"
          ''
            WALLPAPER_DIR="${home}/wallpapers"
            if [ ! -d "$WALLPAPER_DIR" ]; then
              echo "Wallpaper folder does not exist: $WALLPAPER_DIR"
              exit 1
            fi

            WALLPAPER_COUNT=$(${pkgs.findutils}/bin/find -L "$WALLPAPER_DIR" -type f | ${pkgs.coreutils}/bin/wc -l)
            echo "Wallpaper folder: $WALLPAPER_DIR"
            echo "Wallpaper file count: $WALLPAPER_COUNT"
            CLEAN=$(${pkgs.findutils}/bin/find -L "$WALLPAPER_DIR" -type f | ${pkgs.coreutils}/bin/shuf -n 1)
            if [ -n "$CLEAN" ]; then
              echo "Selected wallpaper: $CLEAN"
              /usr/bin/osascript -e "tell application \"System Events\" to tell every desktop to set picture to \"$CLEAN\""
            else
              echo "No wallpapers found in $WALLPAPER_DIR"
              exit 1
            fi
          ''
        ];
        RunAtLoad = true;
        StartInterval = 300;
        StandardErrorPath = "${home}/bob-wallpaper.error.log";
        StandardOutPath = "${home}/bob-wallpaper.log";
      };
    };
  };

  system = {
    stateVersion = 6;
    defaults = {
      NSGlobalDomain = {
        AppleShowAllFiles = true;
        AppleInterfaceStyleSwitchesAutomatically = true;
        KeyRepeat = 1;
      };
      dock = {
        autohide = true;
        wvous-tr-corner = 10; # top right corner puts the display on sleep
      };
      finder.AppleShowAllFiles = true;

    };
  };

  # For flake-based activation from repo root:
  # $ darwin-rebuild switch --flake <repo>#macos
  environment.darwinConfig = "${home}/nix-config/MacOs/system/darwin-configuration.nix";

  nix.package = pkgs.nix;

  # Fix the user group because of a problem, if causes errors, try to remove it
  ids.gids.nixbld = 350;
}
