#!/usr/bin/env bash

#!/usr/bin/env bash
set -euo pipefail

OGMIOS_BIN="result/bin/ogmios"
OUT_DIR="./docker-build"
mkdir -p "$OUT_DIR/lib"

cp "$OGMIOS_BIN" "$OUT_DIR/ogmios"
chmod +w "$OUT_DIR/ogmios"

# Copy all dynamic library dependencies from nix store
for lib in $(ldd "$OGMIOS_BIN" | grep '/nix/store' | awk '{print $3}'); do
  cp "$lib" "$OUT_DIR/lib/"
done

# Grab the dynamic linker
INTERP=$(patchelf --print-interpreter "$OGMIOS_BIN")
cp "$INTERP" "$OUT_DIR/lib/ld-linux.so"

# Patch the binary to use local paths
patchelf --set-interpreter ./lib/ld-linux.so --set-rpath '$ORIGIN/lib' "$OUT_DIR/ogmios"
