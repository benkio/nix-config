{
  config,
  pkgs,
  lib,
  ...
}:

###############################################################################
#                             Bash Configurations                             #
###############################################################################

let
  systemSpecificAliases =
    if pkgs.system == "x86_64-darwin" then
      {
        update = "nix-channel --update && sudo nix-channel --update && sudo darwin-rebuild switch && home-manager switch && nix-collect-garbage --delete-older-than 14d";
      }
    else
      {
        update = "nix-channel --update && sudo nix-channel --update && nixos-rebuild switch && home-manager switch && nix-collect-garbage --delete-older-than 14d";
      };
in
{
  programs.bash = {
    enable = true;
    shellAliases = lib.attrsets.mergeAttrsList [
      systemSpecificAliases
      {
        cat = "bat";
        du = "dust";
        # Consider moving this to programs.git.aliases
        ga = "git add";
        gaa = "git add -A";
        gal = "git add .";
        gall = "git add .";
        gc = "git commit -m";
        gca = "git commit -a -m";
        gcko = "git checkout";
        gco = "git checkout";
        gitlg = "git log --graph --pretty=format:\"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset\" --abbrev-commit";
        gl = "git log --graph --pretty=format:\"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset\" --abbrev-commit";
        gph = "git push -u origin";
        gpl = "git pull";
        gs = "git status";
        gsh = "git stash";
        gst = "git status -sb";
        gw = "git whatchanged";

        h1 = "history 10";
        h2 = "history 20";
        h3 = "history 30";
        h = "history";
        hgrep = "history | grep";
        htop = "btop";
        kaj = "killall -9 java";
        kae = "killall -9 emacs";
        ll = "eza -lh";
        ls = "eza";
        nah = "git clean -df && git checkout -- .";
        paux = "procs";
        pg = "ping google.com -c 5";
        portListen = "sudo lsof -i -P -n | grep LISTEN";
        pscpu = "procs --sortd cpu";
        psmem = "procs --sortd mem";
        sbt = "sbt -Dsbt.supershell=false";
      }
    ];
    historyControl = [ "ignoreboth" ];
    historyIgnore = [
      "ls"
      "ll"
      "cd"
      "exit"
    ];
    historyFileSize = -1;
    historySize = -1;
    initExtra = ''
      shopt -s autocd #Automatically put `cd` before a path
      . ${config.home.homeDirectory}/.nix-profile/etc/profile.d/hm-session-vars.sh
      eval "$(direnv hook bash)"
      if [[ -f ${config.home.homeDirectory}/.bashrcextra ]]
      then
        . ${config.home.homeDirectory}/.bashrcextra
      fi
    '';
  };
}
