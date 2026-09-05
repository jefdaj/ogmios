ogmios-nix
==========

This started as a temporary fork to get Ogmios working with Cardano Node 11.
Then I decided to keep it around because I also added a pure Nix build of the Docker image.
It only covers the `ogmios` build target so far, not `cardano-node-ogmios`.

Usage:

```
nix build .#dockerImage
docker load < result
docker image ls jefdaj/ogmios-nix
```
