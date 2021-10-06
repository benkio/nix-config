{ config, pkgs, lib, ... }:

let
  # TODO: upgrade to the latest in here or do it after
  #       from the emacs folder.
  emacsConfig = pkgs.fetchgit {
    url = "git://github.com/benkio/emacs-config.git";
    rev = "8c05a990fa8d0c772646d5d212f88c15fda8330b";
    sha256 = "0ly2mfcvc8y7s7xd2ih4snnq64p99zrypwwsm7wbbrcz840p8bpm";
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
