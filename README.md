# Temporary cardano-node-ogmios for cardano-node 11

[johnalotoski's fork](https://github.com/johnalotoski/ogmios/tree/feature/node-11.0) seems to be working so far!

I tried Cabal in parallel but went the Docker + Nix way because I ran into a Cabal dependency error.

This what I did:

1. nix build
2. ./patch-binary-for-docker.sh
3. docker build .
4. add resulting image to your docker-compose.yml as usual
