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
    mpv.enable = true;
    htop.enable = true;
    texlive.enable = true;
    zathura.enable = true;
    home-manager.enable = true;
    git = {
      enable = true;
      userName = "Enrico Benini";
      userEmail = "benkio89@gmail.com";
    };
  };
}
