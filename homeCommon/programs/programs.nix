{ config, pkgs, lib, ... }:

###############################################################################
#               General Programs Without Specific Configuration                #
###############################################################################

{

  imports = [
    ./bash.nix
  ];

  programs = {
    alacritty.enable = true;
    awscli.enable = true;
    bat.enable = true;
    direnv.enable = true;
    direnv.nix-direnv.enable = true;
    emacs.enable = true;
    home-manager.enable = true;
    htop.enable = true;
    nix-index.enable = true;
    pandoc.enable = true;
    ssh.enable = true;
    texlive.enable = true;
    yt-dlp.enable = true;
    # rtorrent.enable = true;
    fzf.enable = true;
    git = {
      enable = true;
      userName = "Enrico Benini";
      userEmail = "benkio89@gmail.com";
      extraConfig = {
        fetch = {
          prune = true;
        };
        pull = {
          rebase = false;
        };
      };
      delta = {
        enable = true;
        options = {
          decorations = {
            commit-decoration-style = "bold yellow box ul";
            file-decoration-style = "none";
            file-style = "bold yellow ul";
          };
          features = "decorations";
          whitespace-error-style = "22 reverse";
        };
      };
    };
    irssi = {
      enable = true;
      extraConfig = ''
      settings = {
        core = {
          real_name = "Enrico Benini";
          user_name = "benkio";
          nick = "benkio";
        };
        "irc/dcc" = { dcc_autoget ="yes"; };
      };
      '';
    };
    jq.enable = true;
  };
}
