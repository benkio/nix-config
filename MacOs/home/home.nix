{ config, pkgs, lib, ... }:

let
  # TODO: upgrade to the latest in here or do it after
  #       from the emacs folder.
  emacsConfig = pkgs.fetchgit {
    url = "git://github.com/benkio/emacs-config.git";
    rev = "822f696c1c6e89a208d2c6301cf688c4795c17b9";
    sha256 = "0n0hi6j5xpkxdrpagagrvf5ykb06nlflki1vczici2b02191hr7m";
    leaveDotGit = true;
  };
  bobPaitings = pkgs.fetchgit {
    url = "git://github.com/jwilber/Bob_Ross_Paintings.git";
    rev = "b782b9ec29a847b2d4ba5fe9656396df6a59950f";
    sha256 = "0fs72f2a0q25cyvjjnx0wf1jrmmv7ai5j9389gdybalmwip7f5xk";
  };
in
{
  imports = [
    # ./i3.nix
    # ./firefox.nix
  ];
  nixpkgs.config.allowUnfree = true;
  # fonts.fontconfig.enable = true;

  home = {
    keyboard.layout = "us";
    keyboard.variant = "dvp";
    sessionVariables = {
      LANG = "en_US.utf8";
      EDITOR = "emacsclient -t";          # emacs client terminal
      VISUAL = "emacsclient -c -a emacs"; # emacs client visual
      HISTCONTROL = "ignoreboth";
      JAVA_HOME = "~/.nix-profile/bin/java";
      ESHELL = "/run/current-system/sw/bin/bash";
      NIX_PATH = "darwin-config=$HOME/.nixpkgs/darwin-configuration.nix:$NIX_PATH";
    };
    sessionPath = [ "/run/current-system/sw/bin" ];
    activation.linkEmacsConfig = config.lib.dag.entryAfter [ "writeBoundary" ] ''
      mkdir -p $HOME/.emacs.d $HOME/.local/share/applications $HOME/workspace
      cp -r -n ${emacsConfig}/. $HOME/.emacs.d
      chmod -R 777 $HOME/.emacs.d
    '';

    activation.copyApplications = let
      apps = pkgs.buildEnv {
        name = "home-manager-applications";
        paths = config.home.packages;
        pathsToLink = "/Applications";
      };
    in lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      baseDir="$HOME/Applications/Home Manager Apps"
      if [ -d "$baseDir" ]; then
        rm -rf "$baseDir"
      fi
      mkdir -p "$baseDir"
      for appFile in ${apps}/Applications/*; do
        target="$baseDir/$(basename "$appFile")"
        $DRY_RUN_CMD cp ''${VERBOSE_ARG:+-v} -fHRL "$appFile" "$baseDir"
        $DRY_RUN_CMD chmod ''${VERBOSE_ARG:+-v} -R +w "$target"
      done
    '';
    
    file = {
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
      (sbt.override { jre = pkgs.jdk11; })
      # amule
      awscli
      # bitwarden
      # bleachbit
      # calibre
      # discord
      direnv
      docker
      docker-compose
      elmPackages.elm
      elmPackages.elm-format
      # feh
      # filezilla
      ghc
      ghcid
      haskellPackages.hoogle
      hlint
      # jdk11
      # libsForQt5.kdenlive
      lilypond
      nix-index
      nodePackages.js-beautify
      nodePackages.npm
      nodePackages.typescript
      nodejs
      ormolu
      pandoc
      postgresql
      purescript
      # qjackctl
      # reaper
      scala
      scalafmt
      # slack
      # soulseekqt
      # sound-juicer
      stack
      symbola
      # tdesktop #telegram-desktop
      # teamviewer
      # tixati
      # unetbootin
      unrar
      youtube-dl
      xclip
      # zoom-us
      # BROKEN haskellPackages.ghc-mod
    ];
  };

  programs = {
    emacs.enable = true;
    htop.enable = true;
    # obs-studio.enable = true;
    texlive.enable = true;
    zathura.enable = true;
    home-manager.enable = true;
    #chromium = {
    #  enable = true;
    #  extensions = [
    #    "dbepggeogbaibhgnhhndojpepiihcmeb" # Vimium
    #    "nngceckbapebfimnlniiiahkandclblb" # Bitwarden
    #     "gighmmpiobklfepjocnamgkkbiglidom" # AdBlock
    #  ];
    #};
    git = {
      enable = true;
      userName = "Enrico Benini";
      userEmail = "benkio89@gmail.com";
    };
    bash = {
      enable = true;
      shellAliases = {
        sbt="sbt -Dsbt.supershell=false";
        emacs="emacsclient -c";
        ls="ls -F";
        ll="ls -lh";
        lt="ls --human-readable --size -1 -S --classify";
        h="history";
        h1="history 10";
        h2="history 20";
        h3="history 30";
        hgrep="history | grep";
        gs="git status";
        gst="git status -sb";
        ga="git add";
        gaa="git add -A";
        gal="git add .";
        gall="git add .";
        gca="git commit -a -m";
        gc="git commit -m";
        gcot="git checkout";
        gchekout="git checkout";
        gchckout="git checkout";
        gckout="git checkout";
        go="git push -u origin";
        gsh="git stash";
        gw="git whatchanged";
        gitlg="git log --graph --pretty=format:\"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset\" --abbrev-commit";
        gl="git log --graph --pretty=format:\"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset\" --abbrev-commit";
        nah="git clean -df && git checkout -- .";
        pg="ping google.com -c 5";
        mv="mv -i";
        cp="cp -i";
        ln="ln -i";
        rm="rm -I --preserve-root";
        meminfo="free -m -l -t";
        psmem="ps auxf | sort -nr -k 4";
        psmem10="ps auxf | sort -nr -k 4 | head -10";
        pscpu="ps auxf | sort -nr -k 3";
        pscpu10="ps auxf | sort -nr -k 3 | head -10";
        paux="ps aux | grep";
        usage="du -ch | grep total";
        totalusage="df -hl --total | grep total";
        screenshotScreen="import -window root $(date +%s).png";
        screenshotArea="flameshot gui";
      };
      initExtra = ''
        shopt -s autocd #Automatically put `cd` before a path
        . $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh
        eval "$(direnv hook bash)"
      '';
    };
    vscode = {
      enable = true;
      package = pkgs.vscode;
      extensions = with pkgs.vscode-extensions; [
        ## ms-vsliveshare.vsliveshare not supported in macos + doesn`t work on nixos, yet
        scala-lang.scala
        scalameta.metals
      ];
    };
  };

  services = {
    #udiskie.enable = true;      # Mount external disks automatically
    #gpg-agent = {
    #  enable = true;
    #  defaultCacheTtl = 1800;
    #  enableSshSupport = true;
    #};
  };

  # TODO: split/organize into separate files

}
