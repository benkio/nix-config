{
  config,
  pkgs,
  lib,
  ...
}:

let
  updateAllGitMain = pkgs.fetchurl {
    url = "https://gist.githubusercontent.com/benkio/dbb9523529c875b5472a89eb391df7b4/raw/bd1c25b350c6d4ff16462400c1553f4df92de0a8/UpdateAllGitMain.sc";
    hash = "sha256-qax4YYnA1RvBazFXZzr8YgtjRzafXTP0lrMkXaOjUhI=";
  };
in
{
  home.file."UpdateAllGitMain.sc".source = "${updateAllGitMain}";
}
