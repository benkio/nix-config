{
  config,
  pkgs,
  lib,
  ...
}:

{
  home.activation.linkEmacsConfig = config.lib.dag.entryAfter [ "writeBoundary" ] ''
    if [ ! -d "${config.home.homeDirectory}/.emacs.d" ] || [ ! "$(ls -A ${config.home.homeDirectory}/.emacs.d)" ]; then
      export PRELUDE_URL="https://github.com/benkio/prelude.git" && curl -L https://github.com/bbatsov/prelude/raw/master/utils/installer.sh | sh
    fi
  '';
}
