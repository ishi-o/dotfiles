#!/usr/bin/env bash

pkg_name="nvm"
pkg_version="${NVM_VERSION:-v0.40.3}"

install_nvm() {
  if [ -f "$NVM_DIR/nvm.sh" ]; then
    return 0
  fi

  echo "Installing nvm ${pkg_version}..."
  git clone --depth 1 --branch "$pkg_version" https://github.com/nvm-sh/nvm.git "$NVM_DIR" || return 1

  # Source nvm and install default Node.
  # nvm does not tolerate set -euo pipefail.
  set +euo pipefail
  . "$NVM_DIR/nvm.sh" || return 1
  nvm install node || return 1
  set -euo pipefail
}

install_nvm
