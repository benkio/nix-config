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
    rev = "7a7d942ba9503ad3b4554545bd2d8b9d6d8508cb";
    sha256 = "sha256-fk2KQBX/kt/T35f1dmXavZlhTiSX8dsN8NqCV4nHGP4=";
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
