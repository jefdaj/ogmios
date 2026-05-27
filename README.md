# Temporary cardano-node-ogmios for cardano-node 11

[johnalotoski's fork](https://github.com/johnalotoski/ogmios/tree/feature/node-11.0) seems to be working so far!

I tried Cabal in parallel but went the Docker + Nix way because I ran into a Cabal dependency error.

This what I did:

1. nix flake update
2. nix build
3. ./patch-binary-for-docker.sh
4. docker build .
5. add resulting image to your docker-compose.yml as usual
