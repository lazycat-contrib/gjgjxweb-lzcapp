#!/bin/sh
# Check out the upstream source (pure static site + node server.cjs).
set -eu
VERSION="${GJGJXWEB_VERSION:-master}"
echo "gjgjxweb: fetching ${VERSION}"
rm -rf upstream
mkdir -p upstream
TARBALL="https://codeload.github.com/CzJam/gjgjxweb/tar.gz/${VERSION}"
if command -v curl >/dev/null 2>&1; then
  curl -fsSL "${TARBALL}" | tar -xz -C upstream --strip-components=1
else
  wget -qO- "${TARBALL}" | tar -xz -C upstream --strip-components=1
fi
test -f upstream/index.html
test -f upstream/server.cjs
test -d upstream/js
test -d upstream/assets
# Fix build context: file Dockerfile must live inside its context directory.
cp ./Dockerfile ./upstream/lzc-Dockerfile
echo "gjgjxweb: source ready at ./upstream"
