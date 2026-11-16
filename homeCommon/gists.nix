{
  config,
  pkgs,
  lib,
  ...
}:

let
  updateAllGitMain = pkgs.fetchurl {
    url = "https://gist.githubusercontent.com/benkio/dbb9523529c875b5472a89eb391df7b4/raw/992aec32c1c187393fcc8f94923c8bd662f5bbf2/UpdateAllGitMain.scala";
    hash = "sha256-rEcsClsl378uMuLx+CHtY91bkObXH5iZpEB3w3CFa4E=";
  };
in
{
  home.file."UpdateAllGitMain.scala".source = "${updateAllGitMain}";
}
