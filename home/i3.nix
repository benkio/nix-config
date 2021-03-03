{ config, lib, pkgs, ... }:

let
  mod = "Mod4";
in {
  xsession.windowManager.i3 = {
    enable = true;
    config = {
      terminal = "alacritty";
      modifier = mod;

      fonts = ["DejaVu Sans Mono, FontAwesome 6"];
      workspaceLayout = "tabbed";
      keybindings = lib.mkOptionDefault {
        "${mod}+space" = "exec ${pkgs.dmenu}/bin/dmenu_run";

        # Focus
        "${mod}+Left" = "focus left";
        "${mod}+Down" = "focus down";
        "${mod}+Up" = "focus up";
        "${mod}+Right" = "focus right";

        # Move
        "${mod}+Shift+Left" = "move left";
        "${mod}+Shift+Down" = "move down";
        "${mod}+Shift+Up" = "move up";
        "${mod}+Shift+Right" = "move right";

        "{$mod}+Shift+q" = "kill";
        "{$mod}+f" = "fullscreen";
        "${mod}+t" = "layout toggle tabbed splitv splith";
        "${mod}+Shift+f" = "floating toggle";
        "${mod}+1" = "workspace 1";
        "${mod}+2" = "workspace 2";
        "${mod}+3" = "workspace 3";
        "${mod}+4" = "workspace 4";
        "${mod}+5" = "workspace 5";
        "${mod}+6" = "workspace 6";
        "${mod}+7" = "workspace 7";
        "${mod}+8" = "workspace 8";
        "${mod}+9" = "workspace 9";
        "${mod}+0" = "workspace 10";
        "${mod}+Mod1+Right" = "workspace next";
        "${mod}+Mod1+Left" = "workspace prev";
        "${mod}+Shift+1" = "move container to workspace 1";
        "${mod}+Shift+2" = "move container to workspace 2";
        "${mod}+Shift+3" = "move container to workspace 3";
        "${mod}+Shift+4" = "move container to workspace 4";
        "${mod}+Shift+5" = "move container to workspace 5";
        "${mod}+Shift+6" = "move container to workspace 6";
        "${mod}+Shift+7" = "move container to workspace 7";
        "${mod}+Shift+8" = "move container to workspace 8";
        "${mod}+Shift+9" = "move container to workspace 9";
        "${mod}+Shift+0" = "move container to workspace 10";
        "${mod}+Shift+c" = "reload";
        "${mod}+Shift+r" = "restart";
        "${mod}+b" = "exec firefox";
        "${mod}+Enter" = "exec ${config.xsession.windowManager.i3.config.terminal}";
        "${mod}+w" = "exec gnome-control-center wifi";
        # Media volume controls
        "XF86AudioMute" = "exec amixer sset 'Master' toggle";
        "XF86AudioLowerVolume" = "exec amixer sset 'Master' 5%-";
        "XF86AudioRaiseVolume" = "exec amixer sset 'Master' 5%+";

        # Sreen brightness controls
        "XF86MonBrightnessUp" = "exec brightnessctl s +10% # increase screen brightness";
        "XF86MonBrightnessDown" = "exec brightnessctl s 10%- # decrease screen brightness";

        # Media player controls
        "XF86AudioPlay" = "exec playerctl play-pause";
        "XF86AudioPause" = "exec playerctl play-pause";
        "XF86AudioNext" = "exec playerctl next";
        "XF86AudioPrev" = "exec playerctl previous";
      };
      startup = [
        { command = "nm-applet"; always = true; notification = false; }
        { command = "volumeicon"; always = true; notification = false; }
        { command = "watch -n 900 feh –randomize --bg-scale ~/wallpapers/* "; always = true; notification = false; }
      ];
    };
  };
}
