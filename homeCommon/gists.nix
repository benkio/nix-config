{
  config,
  pkgs,
  lib,
  ...
}:

let
  updateAllGitMain = pkgs.fetchurl {
    url = "https://gist.githubusercontent.com/benkio/dbb9523529c875b5472a89eb391df7b4/raw/ac179aa0902ba573fc2702241fda4efa35376228/UpdateAllGitMain.sc";
    hash = "sha256-+L9DmaYTlYwCkfdzldRWvk/P1MYELc4n1voP2rWX7Qc=";
  };
in
{
  home.file."UpdateAllGitMain.sc".source = "${updateAllGitMain}";
}
