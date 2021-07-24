{ config, pkgs, lib, ... }:

###############################################################################
#               General Programs Without Specific Configuration                #
###############################################################################

{
  programs = {
    obs-studio.enable = true;
    chromium = {
      enable = true;
      extensions = [
        "dbepggeogbaibhgnhhndojpepiihcmeb" # Vimium
        "nngceckbapebfimnlniiiahkandclblb" # Bitwarden
        "gighmmpiobklfepjocnamgkkbiglidom" # AdBlock
      ];
    };
    vscode = {
      extensions = with pkgs.vscode-extensions; [
        ms-vsliveshare.vsliveshare
      ];
    };
  };
}
