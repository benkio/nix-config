{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "nix";
  home.homeDirectory = "/home/nix";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.03";    

  home.sessionVariables = {
    LANG = "en_US.UTF-8";
    #EDITOR = "emacs";
  };

  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
ag
aspell
audacity
autoconf
awscli
bleachbit
calibre
chromium
curl
docker
ffmpeg
filezilla
firefox
gimp
htop
jack2
openjdk
postgresql
sbt
scala
tdesktop #telegra-desktop
tldr
transmission
unrar
vlc
wget
youtube-dl
  ];

  programs.emacs = {
    enable = true;
  };

  programs.git = {
    enable = true;
    userName = "Enrico Benini";
    userEmail = "benkio89@gmail.com";
  };
}
