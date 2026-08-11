#!/usr/bin/env bash

pkg_name="nvm"
pkg_version="${NVM_VERSION:-v0.40.3}"
node_version="${NODE_VERSION:-22}"

install_nvm() {
  if [ ! -f "$NVM_DIR/nvm.sh" ]; then
    echo "Installing nvm ${pkg_version}..."
    git clone --depth 1 --branch "$pkg_version" https://github.com/nvm-sh/nvm.git "$NVM_DIR" || return 1
  fi

  # Source nvm and select a user-managed Node/npm for the following packages.
  # nvm does not tolerate set -euo pipefail.
  set +euo pipefail
  . "$NVM_DIR/nvm.sh" || return 1
  if [ "$(nvm version "$node_version" 2>/dev/null)" = "N/A" ]; then
    nvm install "$node_version" || return 1
  fi
  nvm alias default "$node_version" >/dev/null || return 1
  nvm use --silent default >/dev/null || return 1
  set -euo pipefail
}

install_nvm
