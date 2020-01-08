rm -f node-env.nix
node2nix --nodejs-10 -i node-packages.json -o node-packages.nix -c composition.nix
