{ config, pkgs, ... }:

{
  # Work Related Packages
  environment.systemPackages = with pkgs; [
    google-cloud-sdk
  ];

  homebrew = {
    taps = [
      # commercetools tap doesn't seems to work really well from here. Fallback to manual installation
      {
        name = "commercetools/tap";
        clone_target = "git@github.com:commercetools/homebrew-tap.git";
        force_auto_update = true;
      }
      "hashicorp/tap"
    ];
    brews = [
      "commercetools/tap/kubegen"
      "hashicorp/tap/vault"
    ];
  };
}
