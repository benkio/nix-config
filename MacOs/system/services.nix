{ config, pkgs, ... }:

let
  home = "/Users/benkio";
in
{
  services = {
    redis.enable = true;

    postgresql = {
      enable = true;
      package = (pkgs.postgresql.withPackages (p: [ p.postgis ]));
      dataDir = "${home}/postgresDataDir";
    };

    aerospace = {
      enable = true;
      settings = {
        key-mapping.preset = "dvorak";
        default-root-container-layout = "accordion";
        gaps = {
          outer.left = 8;
          outer.bottom = 8;
          outer.top = 8;
          outer.right = 8;
        };
        mode.main.binding = {
          # Focus
          ctrl-alt-left = "focus left";
          ctrl-alt-down = "focus down";
          ctrl-alt-up = "focus up";
          ctrl-alt-right = "focus right";

          # Move
          ctrl-alt-shift-left = "move left";
          ctrl-alt-shift-down = "move down";
          ctrl-alt-shift-up = "move up";
          ctrl-alt-shift-right = "move right";

          ctrl-alt-1 = "workspace 1";
          ctrl-alt-2 = "workspace 2";
          ctrl-alt-3 = "workspace 3";
          ctrl-alt-4 = "workspace 4";
          ctrl-alt-5 = "workspace 5";
          ctrl-alt-6 = "workspace 6";
          ctrl-alt-7 = "workspace 7";
          ctrl-alt-8 = "workspace 8";
          ctrl-alt-9 = "workspace 9";
          ctrl-alt-shift-1 = "move-node-to-workspace 1";
          ctrl-alt-shift-2 = "move-node-to-workspace 2";
          ctrl-alt-shift-3 = "move-node-to-workspace 3";
          ctrl-alt-shift-4 = "move-node-to-workspace 4";
          ctrl-alt-shift-5 = "move-node-to-workspace 5";
          ctrl-alt-shift-6 = "move-node-to-workspace 6";
          ctrl-alt-shift-7 = "move-node-to-workspace 7";
          ctrl-alt-shift-8 = "move-node-to-workspace 8";
          ctrl-alt-shift-9 = "move-node-to-workspace 9";
          ctrl-alt-tab = "workspace-back-and-forth";

          ctrl-alt-period = "layout tiles horizontal vertical";
          ctrl-alt-comma = "layout accordion horizontal vertical";

          ctrl-alt-enter = "exec-and-forget ~/.nix-profile/bin/wezterm";
          ctrl-alt-e = "exec-and-forget open ~/";
          ctrl-alt-b = "exec-and-forget open \"https://www.google.com\"";
        };
      };
    };
  };
}
