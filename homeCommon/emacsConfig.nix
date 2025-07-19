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
    rev = "3fba786f8bc7225a51822e57c05208545a103231";
    sha256 = "sha256-965nfqfyRVW3G31Sc/aRXCCa8VK+d/JywVQEiNWFcjw=";
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
