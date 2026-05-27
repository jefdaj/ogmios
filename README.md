# Temporary cardano-node-ogmios for cardano-node 11

[johnalotoski's fork][1] seems to be working so far!

I tried Cabal in parallel but went with Nix + Docker because I ran into a Cabal dependency error.

This what I did:

1. nix flake update
2. nix build
3. ./patch-binary-for-docker.sh
4. docker build .
5. add resulting image to your docker-compose.yml as usual (example [here][2])

[1]: https://github.com/johnalotoski/ogmios/tree/feature/node-11.0
[2]: https://github.com/jefdaj/electionguard-cardano/blob/node-11-with-experimental-ogmios/milestone2/cardano-node-ogmios/docker-compose.yml
