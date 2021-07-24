{ config, pkgs, lib, ... }:

let
  # TODO: upgrade to the latest in here or do it after
  #       from the emacs folder.
  emacsConfig = pkgs.fetchgit {
    url = "git://github.com/benkio/emacs-config.git";
    rev = "822f696c1c6e89a208d2c6301cf688c4795c17b9";
    sha256 = "04kg29wn5nj69i5gb6idq2vpkxw2vpxqyfgyf2nnf2jpqgndcygb";
    leaveDotGit = true;
  };
in
{
  home.activation.linkEmacsConfig = config.lib.dag.entryAfter [ "writeBoundary" ] ''
      mkdir -p $HOME/.emacs.d $HOME/.local/share/applications $HOME/workspace
      cp -r -n ${emacsConfig}/. $HOME/.emacs.d
      chmod -R 777 $HOME/.emacs.d
    '';
}
