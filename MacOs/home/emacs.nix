{
  config,
  pkgs,
  lib,
  ...
}:

{
  programs.emacs.enable = true;

  home.sessionVariables = {
    EDITOR = "emacs -nw";
    VISUAL = "emacsclient -c -n -a ''";
  };

  launchd.agents.emacs = lib.mkIf pkgs.stdenv.hostPlatform.isDarwin {
    enable = true;
    config = {
      ProgramArguments = [
        "${config.programs.emacs.finalPackage}/Applications/Emacs.app/Contents/MacOS/Emacs"
        "--fg-daemon"
      ];
      KeepAlive = true;
      ProcessType = "Interactive";
      RunAtLoad = true;
      StandardErrorPath = "${config.home.homeDirectory}/Library/Logs/emacs-daemon.error.log";
      StandardOutPath = "${config.home.homeDirectory}/Library/Logs/emacs-daemon.log";
    };
  };
}
