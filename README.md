# Temporary cardano-node-ogmios for cardano-node 11

This is how I ended up getting it working:

1. nix build
2. ./patch-binary-for-docker.sh
3. docker build .
4. add resulting image to your docker-compose.yml as usual

I also tried cabal build, but didn't pursue it past the first couple errors.
