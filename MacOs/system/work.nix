{ config, pkgs, ... }:

{
  # Work Related Packages
  environment.systemPackages = with pkgs; [
    google-cloud-sdk
  ];

  homebrew = {
    taps = [
      {
        name = "commercetools/tap";
        clone_target = "git@github.com:commercetools/homebrew-tap.git";
        force_auto_update = true;
      }
    ];
    brews = [
      "commercetools/tap/kubegen"
    ];
  };
}
