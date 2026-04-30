{ config, pkgs, ... }:

{
  programs = {
    bash.enable = true;
    nix-index.enable = true;
    zsh.enable = false;
  };
}
