#!/usr/bin/env nix-shell
#! nix-shell -i bash -p nodePackages.node2nix
# NOTE: Script must be run from the node-packages directory

set -eu -o pipefail

rm -f node-env.nix
node2nix --nodejs-16 -i node-packages.json -o node-packages-v16.nix -c composition-v16.nix
node2nix --nodejs-14 -i node-packages.json -o node-packages-v14.nix -c composition-v14.nix

