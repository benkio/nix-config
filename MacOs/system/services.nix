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
          alt-left = "focus left";
          alt-down = "focus down";
          alt-up = "focus up";
          alt-right = "focus right";

          # Move
          alt-shift-left = "move left";
          alt-shift-down = "move down";
          alt-shift-up = "move up";
          alt-shift-right = "move right";

          alt-1 = "workspace 1";
          alt-2 = "workspace 2";
          alt-3 = "workspace 3";
          alt-4 = "workspace 4";
          alt-5 = "workspace 5";
          alt-6 = "workspace 6";
          alt-7 = "workspace 7";
          alt-8 = "workspace 8";
          alt-9 = "workspace 9";
          alt-shift-1 = "move-node-to-workspace 1";
          alt-shift-2 = "move-node-to-workspace 2";
          alt-shift-3 = "move-node-to-workspace 3";
          alt-shift-4 = "move-node-to-workspace 4";
          alt-shift-5 = "move-node-to-workspace 5";
          alt-shift-6 = "move-node-to-workspace 6";
          alt-shift-7 = "move-node-to-workspace 7";
          alt-shift-8 = "move-node-to-workspace 8";
          alt-shift-9 = "move-node-to-workspace 9";
          alt-tab = "workspace-back-and-forth";

          alt-f = "layout floating";
          alt-t = "layout tiling";
        };
      };
    };
  };
}
