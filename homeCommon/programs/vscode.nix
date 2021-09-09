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
    userSettings = {
      "keyboard.dispatch" = "keyCode";
    };
    keybindings = [
      {
        key = "ctrl+x d";
        command = "vscode.openFolder";
      }
      {
        key = "alt+a";
        command = "emacs-mcx.backwardParagraph";
        when = "editorTextFocus && !config.emacs-mcx.useMetaPrefixMacCmd && !suggestWidgetVisible";
      }
      {
        key = "alt+e";
        command = "emacs-mcx.forwardParagraph";
        when = "editorTextFocus && !config.emacs-mcx.useMetaPrefixMacCmd && !suggestWidgetVisible";
      }
      {
        key = "ctrl+/";
        command = "-editor.action.blockComment";
        when = "editorTextFocus && !config.emacs-mcx.useMetaPrefixMacCmd && !editorReadonly";
      }
      {
        key = "ctrl+c f";
        command = "editor.action.formatDocument";
        when = "editorHasDocumentFormattingProvider && editorTextFocus && !editorReadonly && !inCompositeEditor";
      }
      {
        key = "ctrl+x 3";
        command = "workbench.action.splitEditor";
      }
      {
        key = "ctrl+x 3";
        command = "workbench.action.terminal.split";
      }
      {
        key = "ctrl+x 2";
        command = "workbench.action.splitEditorDown";
      }
    ];
  };
}
