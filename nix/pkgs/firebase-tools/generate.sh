#!/usr/bin/env nix-shell
#! nix-shell -i bash -p nodePackages.node2nix
# NOTE: Script must be run from the node-packages directory

set -eu -o pipefail

rm -f node-env.nix
node2nix --nodejs-10 -i node-packages.json -o node-packages-v10.nix -c composition-v10.nix
node2nix --nodejs-12 -i node-packages.json -o node-packages-v12.nix -c composition-v12.nix
node2nix --nodejs-14 -i node-packages.json -o node-packages-v14.nix -c composition-v14.nix

