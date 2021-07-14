{ config, pkgs, lib, ... }:

###############################################################################
#               General Programs Without Specific Configuration                #
###############################################################################

{

  imports = [
    ./bash.nix
    ./vscode.nix
  ];

  programs = {
    emacs.enable = true;
    htop.enable = true;
    obs-studio.enable = true;
    texlive.enable = true;
    zathura.enable = true;
    home-manager.enable = true;
    chromium = {
      enable = true;
      extensions = [
        "dbepggeogbaibhgnhhndojpepiihcmeb" # Vimium
        "nngceckbapebfimnlniiiahkandclblb" # Bitwarden
        "gighmmpiobklfepjocnamgkkbiglidom" # AdBlock
      ];
    };
    git = {
      enable = true;
      userName = "Enrico Benini";
      userEmail = "benkio89@gmail.com";
    };
  };
}
