{
  config,
  pkgs,
  lib,
  ...
}:

let
  updateAllGitMain = pkgs.fetchurl {
    url = "https://gist.githubusercontent.com/benkio/dbb9523529c875b5472a89eb391df7b4/raw/7ad18c9b51f4f2d1f932186538d221f960dee0d9/UpdateAllGitMain.sc";
    hash = "sha256-UkDgQRU629isEKUQBxABPt1FWXkH/QNRj6QkOcujJ68=";
  };
in
{
  home.file."UpdateAllGitMain.sc".source = "${updateAllGitMain}";
}
