{ config, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    aspell
    alacritty
    autoconf
    bat
    byzanz
    curl
    fd
    ffmpeg-full
    gcc
    ghc
    imagemagick
    lsof
    nmap
    ntfs3g
    ngrok
    silver-searcher
    ripgrep
    tldr
    unzip
    wget
    zip
  ];
}
