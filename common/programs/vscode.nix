{ config, pkgs, lib, ... }:

###############################################################################
#                             VSCode Configuration                            #
###############################################################################

{
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
    extensions = with pkgs.vscode-extensions; [
      scala-lang.scala
      scalameta.metals
      editorconfig.editorconfig
    ]++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [{
      name = "emacs-mcx";
      publisher = "tuttieee";
      version = "0.32.0";
      sha256 = "1m6wjy2h3a72iyqf8acxb1ra9ql3n1cmllnwadi8bbrh599n9p6i";
    }];
  };
}
