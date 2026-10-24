{
  config,
  pkgs,
  lib,
  ...
}:

{
  programs = {
    obs-studio.enable = true;
    sbt.enable = true;
    rofi = {
      enable = true;
      package = pkgs.rofi;
      settings = {
        modi = "drun,run,window";
        show-icons = true;
        drun-display-format = "{name}";
        display-drun = "Apps";
        display-run = "Run";
      };
    };
    i3status-rust = {
      enable = true;
      bars = {
        bottom = {
          blocks = [
            {
              block = "net";
              format = " $icon {$ssid|Wired} ";
            }
            {
              block = "battery";
              format = " $icon $percentage {$time |}";
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
              format = " $icon $mem_used_percents.eng(w:2) ";
              format_alt = " $icon_swap $swap_free.eng(w:3,u:B,p:Mi)/$swap_total.eng(w:3,u:B,p:Mi)($swap_used_percents.eng(w:2)) ";
              interval = 30;
              warning_mem = 70;
              critical_mem = 90;
            }
            {
              block = "cpu";
              interval = 1;
              format = " $icon $utilization ";
            }
            {
              block = "load";
              interval = 1;
              format = " $icon $1m.eng(w:4) ";
            }
            {
              block = "sound";
              format = " $icon {$volume.eng(w:2)|} ";
              format_muted = " $icon muted ";
            }
            {
              block = "time";
              interval = 60;
              format = " $timestamp.datetime(f:'%a %d/%m %R') ";
            }
          ];
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
    bash = {
      shellAliases = {
        say = "spd-say";
      };

    };
  };
}
