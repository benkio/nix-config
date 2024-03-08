{ config, pkgs, lib, ... }:

{
  programs = {
    wezterm.enable = true;
    wezterm.extraConfig = ''
     -- Pull in the wezterm API
     local wezterm = require 'wezterm'

     -- This will hold the configuration.
     local config = wezterm.config_builder()

     config.window_padding = {
       left = 0,
       right = 0,
       top = 0,
       bottom = 0,
     }

     config.enable_tab_bar = true
     config.use_fancy_tab_bar = false
     config.hide_tab_bar_if_only_one_tab = true
     config.tab_bar_at_bottom = true
     config.color_scheme = 'Dark+'

     -- and finally, return the configuration to wezterm
     return config
    '';
    obs-studio.enable = true;
    sbt.enable = true;
    i3status-rust = {
      enable = true;
      bars =
        {
          bottom = {
            blocks = [
              {
                block = "net";
                format = " $icon {$signal_strength $ssid $frequency|Wired connection} via $device ";
              }
              {
                block = "battery";
                format = " $percentage {$time |}";
                device = "DisplayDevice";
                driver = "upower";
                missing_format = "";
              }
              {
                block = "disk_space";
                path = "/";
                info_type = "available";
                interval = 60;
                warning = 20.0;
                alert = 10.0;
              }
              {
                block = "memory";
                format = " $icon $mem_used_percents.eng(w:1) ";
                format_alt = " $icon_swap $swap_free.eng(w:3,u:B,p:Mi)/$swap_total.eng(w:3,u:B,p:Mi)($swap_used_percents.eng(w:2)) ";
                interval = 30;
                warning_mem = 70;
                critical_mem = 90;

              }
              {
                block = "cpu";
                interval = 1;
              }
              {
                block = "load";
                interval = 1;
                format = " $icon $1m ";
              }
              { block = "sound"; }
              {
                block = "time";
                interval = 60;
                format = " $timestamp.datetime(f:'%a %d/%m %R') ";
              }
            ];
            settings = {
              theme =  {
                theme = "solarized-dark";
                overrides = {
                  idle_bg = "#123456";
                  idle_fg = "#abcdef";
                };
              };
            };
            icons = "awesome5";
            theme = "gruvbox-dark";
          };
        };
    };
    chromium = {
      enable = true;
      extensions = [
        "dbepggeogbaibhgnhhndojpepiihcmeb" # Vimium
        "nngceckbapebfimnlniiiahkandclblb" # Bitwarden
        "gighmmpiobklfepjocnamgkkbiglidom" # AdBlock
        "lcbjdhceifofjlpecfpeimnnphbcjgnc" # xBrowserSync - sync Id 4a1aea669e6d4c11be1cce243ff0ef76
        "niloccemoadcdkdjlinkgdfekeahmflj" # Pocket
      ];
    };
  };
}
