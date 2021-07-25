{ config, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    aspell
    alacritty
    autoconf
    curl
    fd
    ffmpeg-full
    gcc
    ghc
    imagemagick
    lsof
    nmap
    ntfs3g
    silver-searcher
    ripgrep
    tldr
    unzip
    wget
    zip
  ];
}
