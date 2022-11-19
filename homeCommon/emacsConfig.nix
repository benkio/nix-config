{ config, pkgs, lib, ... }:

let
  # TODO: upgrade to the latest in here or do it after
  #       from the emacs folder.
  emacsConfig = pkgs.fetchgit {
    url = "git://github.com/benkio/emacs-config.git";
    rev = "526a2c7749576090929f70c43cac3a3e18e53716";
    sha256 = "sha256-e1z3Olnwbk3zvvM7tmKAh7up6aCN1xtG9oVk7QKRjYY=";
    leaveDotGit = true;
  };
in
{
  home.activation.linkEmacsConfig = config.lib.dag.entryAfter [ "writeBoundary" ] ''
      if [ ! -d "${config.home.homeDirectory}/.emacs.d" ]; then
        mkdir -p ${config.home.homeDirectory}/.emacs.d
        cp -r -n ${emacsConfig}/. ${config.home.homeDirectory}/.emacs.d
        chmod -R 777 ${config.home.homeDirectory}/.emacs.d
        cd ${config.home.homeDirectory}/.emacs.d
        git remote add origin git@github.com:benkio/emacs-config.git
        git pull origin master
        git checkout -f master
        git clean -fx
        git branch -D fetchgit
      fi
    '';
}
