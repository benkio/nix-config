{ config, pkgs, lib, ... }:

let
  # TODO: upgrade to the latest in here or do it after
  #       from the emacs folder.
  emacsConfig = pkgs.fetchgit {
    url = "git://github.com/benkio/emacs-config.git";
    rev = "df6e9b1320f2d9cc8e688bc37e6e9c00b253baab";
    sha256 = "sha256-fVOxVvasCy8mDJdTUSx4ZZuQBftJ2uMHdwLdLN641b4=";
    leaveDotGit = true;
  };
in
{
  home.activation.linkEmacsConfig = config.lib.dag.entryAfter [ "writeBoundary" ] ''
      if [ ! -d "$HOME/.emacs.d" ]; then
        mkdir -p $HOME/.emacs.d
        cp -r -n ${emacsConfig}/. $HOME/.emacs.d
        chmod -R 777 $HOME/.emacs.d
        cd $HOME/.emacs.d
        git remote add origin git@github.com:benkio/emacs-config.git
        git pull origin master
        git checkout -f master
        git clean -fx
        git branch -D fetchgit
      fi
    '';
}
