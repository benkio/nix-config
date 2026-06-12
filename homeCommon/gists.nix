{
  config,
  pkgs,
  lib,
  ...
}:

let
  updateAllGitMain = pkgs.fetchurl {
    url = "https://gist.githubusercontent.com/benkio/dbb9523529c875b5472a89eb391df7b4/raw/bc79d128baac236b49c1c6a97d6722bbc6722549/UpdateAllGitMain.scala";
    hash = "sha256-rrVEO5wEWLPy692X7GXwp8d8lsrNlYaQjH9Rq7teJVY=";
  };
in
{
  home.file."UpdateAllGitMain.scala".source = "${updateAllGitMain}";
}
