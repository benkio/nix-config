#!/bin/bash
# sudo apt-get install curl git
echo "update nix channel"
nix-channel --add https://github.com/nix-community/home-manager/archive/release-20.09.tar.gz home-manager
sudo  nix-channel --update
echo "install home-manager"
sudo nix-shell '<home-manager>' -A install
nix-env --set-flag priority 0 home-manager
echo "copy nix config"
mkdir -p ~/.config/nixpkgs
cp ./home.nix ~/.config/nixpkgs/
sudo cp ./configuration.nix /etc/nixos/configuration.nix
echo "switch home manager"
sudo nixos-rebuild switch
sudo home-manager switch
