{ config, pkgs, lib, ... }:

let
  # TODO: upgrade to the latest in here or do it after
  #       from the emacs folder.
  emacsConfig = pkgs.fetchgit {
    url = "git://github.com/benkio/emacs-config.git";
    rev = "f4e74803d6cd777d9e95295244784d47e1afc1f1";
    sha256 = "1sjky33xks94aw3zkbl82spn3jz8bjyj8fb6fsm6c8kncm7qgbd7";
    leaveDotGit = true;
  };
  bobPaitings = pkgs.fetchgit {
    url = "git://github.com/jwilber/Bob_Ross_Paintings.git";
    rev = "b782b9ec29a847b2d4ba5fe9656396df6a59950f";
    sha256 = "0fs72f2a0q25cyvjjnx0wf1jrmmv7ai5j9389gdybalmwip7f5xk";
  };
in
{
  imports = [./i3.nix ./firefox.nix];
  nixpkgs.config.allowUnfree = true;
  fonts.fontconfig.enable = true;

  home = {
    keyboard.layout = "us";
    keyboard.variant = "dvp";
    sessionVariables = {
      LANG = "en_US.utf8";
      EDITOR = "emacsclient -t";          # emacs client terminal
      VISUAL = "emacsclient -c -a emacs"; # emacs client visual
    };
    activation.linkEmacsConfig = config.lib.dag.entryAfter [ "writeBoundary" ] ''
      mkdir -p $HOME/.emacs.d $HOME/.local/share/applications $HOME/workspace
      cp -r -n ${emacsConfig}/. $HOME/.emacs.d
      chmod -R 777 $HOME/.emacs.d
    '';

    file = {
      ".bashrc".text = ''
        cp -f ~/.nix-profile/share/applications/*.desktop ~/.local/share/applications/

        shopt -s autocd #Automatically put `cd` before a path
        export HISTCONTROL=ignoreboth
        export XDG_DATA_DIRS=~/.local/share/:~/.nix-profile/share:/usr/share
        export PATH=$PATH:~/.local/bin
        export JAVA_HOME=~/.nix-profile/bin/java

        if [ -f ~/.bash_aliases ]; then
           . ~/.bash_aliases
        fi
      '';

      ".bash_aliases".text = ''
        # SBT
        alias sbt="sbt -Dsbt.supershell=false"

        # Emacs client
        alias emacs="emacsclient -c"

        # Copying from https://raw.githubusercontent.com/vikaskyadav/awesome-bash-alias/master/README.md
        # List files
        alias ls='ls -F'
        alias ll='ls -lh'
        alias lt='ls --human-readable --size -1 -S --classify'

        # History
        alias h="history"
        alias h1="history 10"
        alias h2="history 20"
        alias h3="history 30"
        alias hgrep='history | grep'

        # Git
        alias gs="git status"
        alias gst="git status -sb"
        alias ga="git add"
        alias gaa="git add -A"
        alias gal="git add ."
        alias gall="git add ."
        alias gca="git commit -a -m"
        alias gc="git commit -m"
        alias gcot="git checkout"
        alias gchekout="git checkout"
        alias gchckout="git checkout"
        alias gckout="git checkout"
        alias go="git push -u origin"
        alias gsh='git stash'
        alias gw='git whatchanged'
        alias gitlg="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
        alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
        alias nah="git clean -df && git checkout -- ."

        # Ping
        alias pg="ping google.com -c 5"

        # Confirmation
        alias mv='mv -i'
        alias cp='cp -i'
        alias ln='ln -i'
        alias rm='rm -I --preserve-root'

        # Free and Used
        alias meminfo="free -m -l -t"

        # Get top process eating memory
        alias psmem="ps auxf | sort -nr -k 4"
        alias psmem10="ps auxf | sort -nr -k 4 | head -10"

        # Get top process eating cpu
        alias pscpu="ps auxf | sort -nr -k 3"
        alias pscpu10="ps auxf | sort -nr -k 3 | head -10"

        # Get details of a process
        alias paux='ps aux | grep'

        # Grabs the disk usage in the current directory
        alias usage='du -ch | grep total'

        # Gets the total disk usage on your machine
        alias totalusage='df -hl --total | grep total'
      '';

      ".ghci".text = ''
        :set prompt "\ESC[38;5;208m\STXλ>\ESC[m\STX "

        :def hoogle \s -> return $ ":! hoogle --count=15 \"" ++ s ++ "\""
        -- Better errors
        :set -ferror-spans -freverse-errors -fprint-expanded-synonyms
      '';

      ".xprofile".text = ''
        # Add here different display resolutions using xrandr
        xrandr --output "virtual1" --mode 1920x1200 #Virual Machine resolution

        # Services
        systemctl --user start udiskie.service emacs.service
      '';
      "wallpapers".source = "${bobPaitings}/data/paintings";
    };

    packages = with pkgs; [
      awscli
      bitwarden
      bleachbit
      calibre
      discord
      docker
      elmPackages.elm
      elmPackages.elm-format
      obs-linuxbrowser # Need extra steps to be added, obs doesn't have the plugin section. See the end of the file
      feh
      filezilla
      ghc
      ghcid
      hlint
      jdk11
      kdeApplications.kdenlive
      lilypond
      haskellPackages.hoogle
      # BROKEN haskellPackages.ghc-mod
      nodePackages.npm
      nodePackages.typescript
      nodePackages.js-beautify
      nodejs
      nix-index
      ormolu
      pandoc
      postgresql
      purescript
      qjackctl
      reaper
      (sbt.override { jre = pkgs.jdk11; })
      scala
      slack
      sound-juicer
      soulseekqt
      stack
      symbola
      tdesktop #telegram-desktop
      tixati
      teamviewer
      unetbootin
      unrar
      youtube-dl
      amule
    ];
  };

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
    bash = {
      enable = true;
      initExtra = ''
        . $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh
      '';
    };
  };

  services = {
    udiskie.enable = true;      # Mount external disks automatically
    gpg-agent = {
      enable = true;
      defaultCacheTtl = 1800;
      enableSshSupport = true;
    };
  };

  # obs-linuxbrowser extra steps
  # We don't have a wrapper which can supply obs-studio plugins so you have to
  # somewhat manually install this:

  # nix-env -f . -iA obs-linuxbrowser
  # mkdir -p ~/.config/obs-studio/plugins
  # ln -s ~/.nix-profile/share/obs/obs-plugins/obs-linuxbrowser ~/.config/obs-studio/plugins/


  # TODO: split/organize into separate files

}
