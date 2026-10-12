{
  ...
}:

{
  programs.emacs.enable = true;

  home.sessionVariables = {
    EDITOR = "emacs -nw";
    VISUAL = "emacsclient -c -n";
  };

  services.emacs = {
    enable = true;
    startWithUserSession = "graphical";
  };
}
