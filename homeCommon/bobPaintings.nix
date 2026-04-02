{
  config,
  pkgs,
  lib,
  ...
}:

let
  bobPaintings = builtins.fetchGit {
    url = "https://github.com/jwilber/Bob_Ross_Paintings";
    ref = "master";
  };
in
{
  home.file."wallpapers".source = "${bobPaintings}/data/paintings";
}
