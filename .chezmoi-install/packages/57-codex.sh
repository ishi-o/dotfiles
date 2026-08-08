#!/usr/bin/env bash

pkg_name="codex"
pkg_version="${CODEX_VERSION:-latest}"

install_codex() {
  if check_installed codex; then
    return 0
  fi

  # Source nvm so npm/node are available
  if [ -f "$HOME/.nvm/nvm.sh" ]; then
    set +euo pipefail
    . "$HOME/.nvm/nvm.sh"
    set -euo pipefail
  fi

  if ! check_installed npm; then
    echo "Skipping codex: npm not found (install nvm/node first)"
    return 0
  fi

  echo "Installing codex ${pkg_version} via npm..."
  npm install -g @openai/codex || return 1
}

install_codex
