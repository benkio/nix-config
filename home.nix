{ config, pkgs, lib, ... }:

let
   packages = import <nixpkgs> {};
   # TODO: upgrade to the latest in here or do it after
   #       from the emacs folder.
   emacsConfig = packages.fetchgit { 
      url = "git://github.com/benkio/emacs-config.git";
      rev = "053ad1ded292bfa049c231d680c1c9530571aa37";
      sha256 = "1cnbkpyv3ihs7zjpivmi4v382k9pn3mbb1hlywmkpw0768ianbl6";
      leaveDotGit = true;
    };
    
in 
{
  programs.home-manager.enable = true;

  home.keyboard.layout = "us";
  home.keyboard.variant = "dvp";

  home.sessionVariables = {
    LANG = "en_US.UTF-8";
    EDITOR = "emacs";
  };

  nixpkgs.config.allowUnfree = true;
  fonts.fontconfig.enable = true;
  programs.chromium = {
    enable = true;
    #extensions = [
    #  { id = "hfjbmagddngcpeloejdejnfgbamkjaeg"; } # Vimium  
    #];
  };
  # TODO: programs.firefox.extensions
  home.packages = with pkgs; [  
    ag
    aspell
    audacity
    autoconf
    awscli
    bleachbit
    calibre
    curl
    dejavu_fonts
    discord
    docker
    ffmpeg
    filezilla
    firefox
    gimp
    gcc
    ghc
    ghcid
    # haskellPackages.hindent marked as broken
    hexchat
    hlint
    imagemagick
    jack2
    lilypond
    nettools
    nodejs
    nodePackages.typescript
    nodePackages.npm
    pandoc
    purescript
    ntfs3g
    jdk8
    postgresql
    pulseaudioFull #TODO: find out how to do .override { jackaudioSupport = true; }
    qjackctl
    sbt
    scala
    slack
    stack
    ghcid
    symbola
    tdesktop #telegra-desktop
    tldr
    transmission
    unrar
    unzip
    vlc
    wget
    youtube-dl
    ];

  programs.emacs.enable = true;
  programs.htop.enable = true;

  home.activation.linkEmacsConfig = config.lib.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p $HOME/.emacs.d
    mkdir -p $HOME/.local/share/applications
    cp -r -n ${emacsConfig}/. $HOME/.emacs.d
    chmod -R 777 $HOME/.emacs.d
    mkdir -p $HOME/workspace
    systemctl --user start dropbox.service udiskie.service
  '';
  programs.git = {
    enable = true;
    userName = "Enrico Benini";
    userEmail = "benkio89@gmail.com";
  };

  home.file.".bashrc".text = ''
    source /home/nix/.nix-profile/etc/profile.d/nix.sh
    export XDG_DATA_DIRS=~/.local/share/:~/.nix-profile/share:/usr/share
    cp -f ~/.nix-profile/share/applications/*.desktop ~/.local/share/applications/
  '';

  programs.obs-studio.enable = true;
  programs.texlive.enable = true;
  programs.zathura.enable = true;
  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 1800;
    enableSshSupport = true;
  };

  home.file.".ghci".text = ''
    :set prompt "λ> "
  '';
  
# TODO: add the default applications
#environment.etc."xdg/mimeapps.list" = {
#  text = ''
#    [Default Applications]
#    mime/type=foo.desktop;
#  '';
#};

  # TODO: split/organize into separate files
  
}
