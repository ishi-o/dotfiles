#!/usr/bin/env bash

pkg_name="codegraph"
pkg_version="${CODEGRAPH_VERSION:-latest}"

install_codegraph() {
  if check_installed codegraph; then
    return 0
  fi

  if [ -f "$NVM_DIR/nvm.sh" ]; then
    set +euo pipefail
    . "$NVM_DIR/nvm.sh"
    set -euo pipefail
  fi

  if ! check_installed npm; then
    echo "Skipping codegraph: npm not found (install nvm/node first)"
    return 0
  fi

  echo "Installing codegraph ${pkg_version} via npm..."
  npm install -g codegraph || return 1
}

install_codegraph
