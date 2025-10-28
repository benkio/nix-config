{
  config,
  pkgs,
  lib,
  ...
}:

let
  updateAllGitMain = pkgs.fetchurl {
    url = "https://gist.githubusercontent.com/benkio/dbb9523529c875b5472a89eb391df7b4/raw/1de7dfac1a283b7552b7146fda377ec51bc07deb/UpdateAllGitMain.sc";
    hash = "sha256-2R62FubjIqjPERyq3m8whSkHiCLTU5nXB8gXsO2fnJU=";
  };
in
{
  home.file."UpdateAllGitMain.sc".source = "${updateAllGitMain}";
}
