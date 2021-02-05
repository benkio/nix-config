#!/bin/bash
# sudo apt-get install curl git
echo "copy nix config"
mkdir -p ~/.config/nixpkgs
cp ./home.nix ~/.config/nixpkgs/
sudo cp ./configuration.nix /etc/nixos/configuration.nix
echo "switch home manager"
sudo nixos-rebuild switch
sudo home-manager switch
