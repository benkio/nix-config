{
  config,
  pkgs,
  lib,
  ...
}:

let
  bobPaintings = builtins.fetchGit {
    url = "https://github.com/jwilber/Bob_Ross_Paintings";
    rev = "f8741b2ba36d7b7a6e3fc87cb757ea73c9da6e1f";
  };
in
{
  home.file."wallpapers".source = "${bobPaintings}/data/paintings";
}
