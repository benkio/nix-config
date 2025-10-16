{ config, pkgs, ... }:

{
  programs = {
    bash.enable = true;
    direnv.enable = true;
    nix-index.enable = true;
    zsh.enable = false;
  };
}
