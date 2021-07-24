{ config, pkgs, lib, ... }:

###############################################################################
#                             Bash Configurations                             #
###############################################################################

{
  programs.bash = {
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
}
