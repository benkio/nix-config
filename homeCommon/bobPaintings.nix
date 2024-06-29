{
  config,
  pkgs,
  lib,
  ...
}:

let
  bobPaitings = pkgs.fetchgit {
    url = "https://github.com/jwilber/Bob_Ross_Paintings.git";
    rev = "90dcb68c20502b0151497c0dad7d08a3ceedaf85";
    sha256 = "sha256-TMt+hr1pewzFg6pFfgaAuC6Pop6wPZNAvn/lc8PH8tk=";
  };
in
{
  home.file."wallpapers".source = "${bobPaitings}/data/paintings";
}
