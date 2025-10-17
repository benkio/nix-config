{ config, pkgs, ... }:

{
  # Work Related Packages
  environment.systemPackages = with pkgs; [
    google-cloud-sdk
  ];
}
