{
  config,
  pkgs,
  lib,
  ...
}:

let
  # TODO: upgrade to the latest in here or do it after
  #       from the emacs folder.
  emacsConfig = pkgs.fetchgit {
    url = "https://github.com/benkio/emacs-config.git";
    rev = "87ea70fce0f7d507b0c1be0f7a3c08c81ac6151e";
    sha256 = "sha256-Ob64hINFpTda96gYx4ZHY7S+3wwiLCJTyAP6jynr9Ck=";
    leaveDotGit = true;
  };
in
{
  home.activation.linkEmacsConfig = config.lib.dag.entryAfter [ "writeBoundary" ] ''
    if [ ! -d "${config.home.homeDirectory}/.emacs.d" ] || [ ! "$(ls -A ${config.home.homeDirectory}/.emacs.d)" ]; then
      mkdir -p ${config.home.homeDirectory}/.emacs.d
      cp -r -n ${emacsConfig}/. ${config.home.homeDirectory}/.emacs.d
      chmod -R 777 ${config.home.homeDirectory}/.emacs.d
      cd ${config.home.homeDirectory}/.emacs.d
      ${pkgs.git}/bin/git remote add origin git@github.com:benkio/emacs-config.git
    fi
  '';
}
