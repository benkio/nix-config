{
  config,
  lib,
  pkgs,
  ...
}:

###############################################################################
#                                  Sway Config                                #
###############################################################################

let
  mod = "Mod4";
in
{
  wayland.windowManager.sway = {
    # influenced by https://github.com/addy-dclxvi/i3-starterpack/tree/master
    enable = true;
    config = {
      terminal = "wezterm";
      modifier = mod;
      workspaceLayout = "tabbed";
      input = {
        "*" = {
          # omitting other config options
          xkb_layout = "us";
          xkb_variant = "dvp";
          xkb_numlock = "enabled";
        };
      };
      output = {
        "*" = {
          scale = "1.3";
        };
      };
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

        "${mod}+Shift+q" = "kill";
        "${mod}+f" = "fullscreen";
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
        # Modify from Shift because in dvorak programmer numbers accesible with Shift
        "${mod}+Mod1+parenleft" = "move container to workspace 1";
        "${mod}+Mod1+parenright" = "move container to workspace 2";
        "${mod}+Mod1+braceleft" = "move container to workspace 3";
        "${mod}+Mod1+plus" = "move container to workspace 4";
        "${mod}+Mod1+braceright" = "move container to workspace 5";
        "${mod}+Mod1+bracketleft" = "move container to workspace 6";
        "${mod}+Mod1+bracketright" = "move container to workspace 7";
        "${mod}+Mod1+exclam" = "move container to workspace 8";
        "${mod}+Mod1+equal" = "move container to workspace 9";
        "${mod}+Mod1+asterisk" = "move container to workspace 10";
        "${mod}+Shift+c" = "reload";
        "${mod}+Shift+r" = "restart";
        "${mod}+b" = "exec floorp";
        "${mod}+Shift+b" = "exec blueman-manager";
        "${mod}+e" = "exec nautilus";
        "Print" = "exec rofi-screenshot -d ~/";
        "${mod}+Return" = "exec ${config.wayland.windowManager.sway.config.terminal}";
        "${mod}+w" = "exec gnome-control-center wifi";
        # Media volume controls
        "XF86AudioMute" = "exec pamixer -t";
        "XF86AudioRaiseVolume" = "exec pamixer -i 5"; # to decrease 5%
        "XF86AudioLowerVolume" = "exec pamixer -d 5"; # to increase 5%

        # Sreen brightness controls
        "XF86MonBrightnessUp" = "exec brightnessctl s +10% # increase screen brightness";
        "XF86MonBrightnessDown" = "exec brightnessctl s 10%- # decrease screen brightness";

        # Media player controls
        "XF86AudioPlay" = "exec playerctl play-pause";
        "XF86AudioPause" = "exec playerctl play-pause";
        "XF86AudioNext" = "exec playerctl next";
        "XF86AudioPrev" = "exec playerctl previous";
      };
      fonts = {
        names = [
          "NotoSans Nerd Font"
          "DejaVu Sans Mono"
          "Symbola"
        ];
        size = 18.0;
      };
      startup = [
        {
          command = "nm-applet --sm-disable";
          always = false;
        }
        {
          command = "volumeicon";
          always = false;
        }
        {
          command = "\"sleep 1; swww-daemon & sleep 1; while true; do swww img ${config.home.homeDirectory}/wallpapers/$(ls ${config.home.homeDirectory}/wallpapers | shuf -n 1) --transition-fps 30 --transition-type=random --transition-bezier=0,0.84,1,1; sleep 600; done\"";
          always = false;
        }
      ];
      bars = [
        {
          statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ${config.home.homeDirectory}/.config/i3status-rust/config-bottom.toml";
          fonts = {
            names = [
              "NotoSans Nerd Font"
              "DejaVu Sans Mono"
              "Symbola"
            ];
            size = 18.0;
          };
          colors = {
            background = "#2f343f";
            statusline = "#2f343f";
            separator = "#4b5262";
            focusedWorkspace = {
              border = "#2f343f";
              background = "#bf616a";
              text = "#d8dee8";
            };
            activeWorkspace = {
              border = "#2f343f";
              background = "#2f343f";
              text = "#d8dee8";
            };
            inactiveWorkspace = {
              border = "#2f343f";
              background = "#2f343f";
              text = "#d8dee8";
            };
            urgentWorkspace = {
              border = "#2f343f";
              background = "#ebcb8b";
              text = "#2f343f";
            };
          };
        }
      ];
    };
  };
}
