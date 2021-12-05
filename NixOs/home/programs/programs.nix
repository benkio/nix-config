{ config, pkgs, lib, ... }:

{
  programs = {
    obs-studio.enable = true;
    chromium = {
      enable = true;
      extensions = [
        "dbepggeogbaibhgnhhndojpepiihcmeb" # Vimium
        "nngceckbapebfimnlniiiahkandclblb" # Bitwarden
        "gighmmpiobklfepjocnamgkkbiglidom" # AdBlock
        "lcbjdhceifofjlpecfpeimnnphbcjgnc" # xBrowserSync
      ];
    };
    vscode = {
      extensions = with pkgs.vscode-extensions; [
        ms-vsliveshare.vsliveshare
      ];
    };
  };
}
