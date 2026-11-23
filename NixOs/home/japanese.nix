{ pkgs, ... }:

{
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      waylandFrontend = true;
      addons = [
        pkgs.fcitx5-mozc
        pkgs.fcitx5-gtk
      ];
    };
  };

  # Use explicit files instead of i18n.inputMethod.fcitx5.settings, which makes
  # ~/.config/fcitx5 a read-only store symlink. These leave the directory itself
  # writable so fcitx5 can still create runtime state there.
  xdg.configFile = {
    "fcitx5/config".text = ''
      [Behavior]
      ActiveByDefault=False

      [Hotkey/TriggerKeys]
      0=Control+Shift+space
      1=Zenkaku_Hankaku
      2=Hangul
    '';
    "fcitx5/profile".text = ''
      [Groups/0]
      Name=Default
      Default Layout=us-dvorak
      DefaultIM=mozc

      [Groups/0/Items/0]
      Name=keyboard-us-dvorak
      Layout=

      [Groups/0/Items/1]
      Name=mozc
      Layout=us-dvorak

      [GroupOrder]
      0=Default
    '';
  };
}
