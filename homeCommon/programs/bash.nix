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
    if lib.strings.hasInfix "darwin" pkgs.stdenv.hostPlatform.system then
      {
        update = "scala-cli ~/UpdateAllGitMain.sc ; nix-channel --update && sudo -H nix-channel --update && sudo -H darwin-rebuild switch; home-manager switch ; nix-collect-garbage --delete-older-than 14d; sudo -H nix-collect-garbage --delete-older-than 14d";
      }
    # Nixos / Linux
    else
      {
        bluetooth = "blueman-manager &";
        open = "xdg-open";
        restart-wifi = "sudo systemctl restart NetworkManager";
        update = "scala-cli ~/UpdateAllGitMain.sc ; nix-channel --update && sudo -H nix-channel --update && nixos-rebuild switch --sudo; home-manager switch ; nix-collect-garbage --delete-older-than 14d; sudo -H nix-collect-garbage --delete-older-than 14d";
      };
in
{
  programs.bash = {
    enable = true;
    shellAliases = lib.attrsets.mergeAttrsList [
      systemSpecificAliases
      {
        #1 Consider moving this to programs.git.aliases
        battery = "upower -i /org/freedesktop/UPower/devices/battery_BAT0";
        cat = "bat";
        cp = "cp -iv";
        du = "dust";
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
        gw = "git diff --cached";
        h = "history";
        h1 = "history 10";
        h2 = "history 20";
        h3 = "history 30";
        hgrep = "history | grep";
        htop = "btop";
        kae = "killall -9 emacs";
        kaj = "killall -9 java";
        ll = "eza -lh";
        ls = "eza";
        mkdir = "mkdir -vp";
        mv = "mv -iv";
        nah = "git clean -df && git checkout -- .";
        paux = "procs";
        pg = "ping google.com -c 5";
        portListen = "sudo lsof -i -P -n | grep LISTEN";
        ps = "procs";
        pscpu = "procs --sortd cpu";
        psmem = "procs --sortd mem";
        restart-ssh-agent = "eval \"$(ssh-agent -s)\"";
        ripCDMp3 = "abcde -B -G -o mp3 -x";
        sbt = "sbt -Dsbt.supershell=false";
        wifi = "nmtui";
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

      if [[ $(uname -r) =~ WSL ]]; then
        # WSL detected
        setxkbmap -layout us -variant dvorak
        export XDG_RUNTIME_DIR=/mnt/wslg/runtime-dir
      fi
    '';
  };
}
