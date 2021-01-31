!#/bin/bash
sudo apt-get install curl git
curl -L https://nixos.org/nix/install | sh
source $HOME/.nix-profile/etc/profile.d/nix.sh
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install
cp ./home.nix ~/.config/nixpkgs/
home-manager switch
