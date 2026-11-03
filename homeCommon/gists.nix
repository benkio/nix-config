{
  config,
  pkgs,
  lib,
  ...
}:

let
  updateAllGitMain = pkgs.fetchurl {
    url = "https://gist.githubusercontent.com/benkio/dbb9523529c875b5472a89eb391df7b4/raw/337f8dad002591f9a15d92033fced137fa8c96e0/UpdateAllGitMain.scala";
    hash = "sha256-+1RQsSmg1Fri858cgCVQLg5sYQS5ayxu1GgF6m6vpKk=";
  };
in
{
  home.file."UpdateAllGitMain.scala".source = "${updateAllGitMain}";
}
