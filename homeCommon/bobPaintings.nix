{ config, pkgs, lib, ... }:

let
  bobPaitings = pkgs.fetchgit {
    url = "git://github.com/jwilber/Bob_Ross_Paintings.git";
    rev = "b782b9ec29a847b2d4ba5fe9656396df6a59950f";
    sha256 = "0fs72f2a0q25cyvjjnx0wf1jrmmv7ai5j9389gdybalmwip7f5xk";
  };
in
{
  home.file."wallpapers".source = "${bobPaitings}/data/paintings";
}
