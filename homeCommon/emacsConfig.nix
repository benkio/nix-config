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
    rev = "be0b04d60ff0588fabad885fc6cbf9d025f51309";
    sha256 = "sha256-JnZW7d9unp7TnkrtZHeyV1lXO8Jd3sfdymC3whv+eRI=";
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
      git remote add origin git@github.com:benkio/emacs-config.git
      git pull origin main
      git checkout -f main
      git clean -fx
      git branch -D fetchgit
    fi
  '';
}
