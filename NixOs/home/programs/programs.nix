{ config, pkgs, lib, ... }:

{
  programs = {
    wezterm.enable = true;
    obs-studio.enable = true;
    sbt.enable = true;
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
