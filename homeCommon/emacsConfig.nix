{
  config,
  pkgs,
  lib,
  ...
}:

let
  emacsPreludeInstallation = pkgs.writeShellApplication {
    name = "emacs-prelude";
    runtimeInputs = [
      pkgs.git
      pkgs.curl
    ];
    text = ''
      if [ ! -d "${config.home.homeDirectory}/.emacs.d" ]; then
	export PRELUDE_URL="https://github.com/benkio/prelude.git"
	curl -L https://github.com/bbatsov/prelude/raw/master/utils/installer.sh | sh
      else
	echo "emacs folder exists"
      fi
    '';
  };
in
{
  home.packages = [ emacsPreludeInstallation ];

  home.activation.linkEmacsConfig = config.lib.dag.entryAfter [ "writeBoundary" ] ''
    ${emacsPreludeInstallation}/bin/emacs-prelude
  '';
}