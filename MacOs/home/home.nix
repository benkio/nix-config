{ config, pkgs, lib, ... }:

{
  imports = [
    ../../common/emacsConfig.nix
    ../../common/bobPaintings.nix
  ];
  nixpkgs.config.allowUnfree = true;

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
      LC_ALL="en_US.UTF-8";
      LC_CTYPE="en_US.UTF-8";
      NIX_PATH = "darwin-config=$HOME/.nixpkgs/darwin-configuration.nix:$NIX_PATH";
    };
    sessionPath = [ "/run/current-system/sw/bin" ];
    
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
    };

    packages = with pkgs; [
      awscli
      direnv
      docker
      docker-compose
      elmPackages.elm
      elmPackages.elm-format
      ghc
      ghcid
      haskellPackages.hoogle
      hlint
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
      scala
      scalafmt
      stack
      symbola
      unrar
      xclip
      youtube-dl
(sbt.override { jre = pkgs.jdk11; })
    ];
  };

  programs = {
    emacs.enable = true;
    htop.enable = true;
    texlive.enable = true;
    zathura.enable = true;
    home-manager.enable = true;
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
        scala-lang.scala
        scalameta.metals
      ];
    };
  };

}
