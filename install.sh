#!/bin/bash
# sudo apt-get install curl git
echo "install nix" 
curl -L https://nixos.org/nix/install | sh
echo "run nix script"
. ~/.nix-profile/etc/profile.d/nix.sh
echo "update nix channel"
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
echo "install home-manager"
nix-shell '<home-manager>' -A install
echo "copy nix config"
cp ./home.nix ~/.config/nixpkgs/
echo "switch home manager"
home-manager switch
