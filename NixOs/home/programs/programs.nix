{ config, pkgs, lib, ... }:

{
  programs = {
    wezterm.enable = true;
    obs-studio.enable = true;
    sbt.enable = true;
    i3status-rust = {
      enable = true;
      bars =
        {
          bottom = {
            blocks = [
              {
                block = "ethernet enp1s0";
                format_up = "<span background='#88c0d0'>  %ip </span>";
                format_down = "<span background='#88c0d0'>  Disconnected </span>";
              }
              {
                block = "wireless wlp2s0";
                format_up = "<span background='#b48ead'>  %essid </span>";
                format_down = "<span background='#b48ead'>  Disconnected </span>";
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
                format_mem = " $icon $mem_used_percents ";
                format_swap = " $icon $swap_used_percents ";
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
