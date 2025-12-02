{
  config,
  pkgs,
  lib,
  ...
}:

let
  updateAllGitMain = pkgs.fetchurl {
    url = "https://gist.githubusercontent.com/benkio/dbb9523529c875b5472a89eb391df7b4/raw/402d7513e83a1fee00c49c25bad5e9d317e0b2fe/UpdateAllGitMain.sc";
    hash = "sha256-sHBtrGwrX6F8qPM627C3Egm5AFk39sCU3IjnnXTbbL0=";
  };
in
{
  home.file."UpdateAllGitMain.sc".source = "${updateAllGitMain}";
}
