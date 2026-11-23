{ config, pkgs, ... }:

let
  enableJapaneseInputSource = pkgs.writeText "enable-japanese-input-source.swift" (
    builtins.readFile ./enable-japanese-input-source.swift
  );
in
{
  home.activation = {
    japaneseInput = config.lib.dag.entryAfter [ "writeBoundary" ] ''
      $DRY_RUN_CMD /usr/bin/swift ${enableJapaneseInputSource}

      # Keep romaji/hiragana mapped through Dvorak.
      $DRY_RUN_CMD /usr/bin/defaults write com.apple.inputmethod.Kotoeri JIMPrefRomajiKeyboardLayoutKey -string com.apple.keylayout.Dvorak

      # Symbolic hotkey 60 is "Select the previous input source"; replace the
      # default Ctrl+Space with Ctrl+Shift+Space. 393216 = control + shift.
      $DRY_RUN_CMD /usr/bin/defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 60 '<dict><key>enabled</key><true/><key>value</key><dict><key>parameters</key><array><integer>32</integer><integer>49</integer><integer>393216</integer></array><key>type</key><string>standard</string></dict></dict>'
    '';
  };
}
