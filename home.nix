{ config, pkgs, ... }:

let
   packages = import <nixpkgs> {};
   emacsConfig = packages.fetchgit {
      url = "git://github.com/benkio/emacs-config.git";
      rev = "053ad1ded292bfa049c231d680c1c9530571aa37";
      sha256 = "0643pw2c0wsf45f8diw0yyfqz1vbdbixzjhkgqi4l3bak00zbvjy";
      leaveDotGit = true;
    };
in 
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
    EDITOR = "emacs";
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

  home.activation.linkEmacsConfig = config.lib.dag.entryAfter [ "emacs" ] ''
    mkdir -p $HOME/.emacs.d
    cp -r ${emacsConfig}/. $HOME/.emacs.d
    chmod -R 777 $HOME/.emacs.d
  '';
  programs.git = {
    enable = true;
    userName = "Enrico Benini";
    userEmail = "benkio89@gmail.com";
  };
}
