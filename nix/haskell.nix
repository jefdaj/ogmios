# This creates the Haskell package set.
# https://input-output-hk.github.io/haskell.nix/user-guide/projects/
haskell-nix: src: inputMap: haskell-nix.cabalProject' {
  inherit inputMap;
  name = "ogmios";
  src = haskell-nix.haskellLib.cleanSourceWith {
    name = "ogmios-src";
    inherit src;
    subDir = "server";
    filter = path: type:
      builtins.all (x: x) [
        (baseNameOf path != "package.yaml")
      ];
  };

  sha256map = {
    # ogmios repo cabal.project missing srp nix hashes
    "https://github.com/CardanoSolutions/cardano-ledger.git"."5cca15a1f0629c11e8d4d4daeb73428684f9c34f" = "sha256-gRADCB04orqPB2Lkadus0C1O+/Nm5oJHuddXm8wgx5w=";
    "https://github.com/CardanoSolutions/ouroboros-consensus.git"."5bbbf9c8b4cd3dc3e3a80d13ef54b3a2ee43a585" = "sha256-Pihx/gVf1GVGElAkMeu2AKtIpPfoCj4faQ0DTjajrqc=";
    "https://github.com/CardanoSolutions/ouroboros-network.git"."d3477c4e6b3243f89afb974914ea423a75873fa0" = "sha256-eMfFcV6dFEm10yFyi0wKVE1c0ob4X8UmnhIp5A4W/bE=";
  };

  # Ogmios repo server/modules/fast-bech32/fast-bech32.cabal requires base >=4.17 && <5
  # Ogmios dep tree-diff requires base < 4.20
  #
  # This leaves ghc948, ghc965, ghc982 as options:
  #   ghc948: fails to build src/ouroboros-consensus/Ouroboros/Consensus/Block/RealPoint.hs:97:65: error: Could not deduce (HasHeader blk)
  #   ghc965: builds
  #   ghc982: builds
  compiler-nix-name = "ghc984";

  modules = [
    {
      doHaddock = false;
      doCheck = false;
    }
    ({ pkgs, ... }: {
      # Use the VRF fork of libsodium
      packages = {
        cardano-crypto-praos.components.library.pkgconfig = pkgs.lib.mkForce [
          [ pkgs.libsodium-vrf ]
        ];
        cardano-crypto-class.components.library.pkgconfig = pkgs.lib.mkForce [
          [ pkgs.libsodium-vrf pkgs.secp256k1 pkgs.libblst ]
        ];
      };
    })
  ];
}
