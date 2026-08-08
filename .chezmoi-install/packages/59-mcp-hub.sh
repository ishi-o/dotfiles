#!/usr/bin/env bash

pkg_name="mcp-hub"
pkg_version="${MCP_HUB_VERSION:-latest}"

install_mcp_hub() {
  if check_installed mcp-hub; then
    return 0
  fi

  # Source nvm so npm/node are available
  if [ -f "$HOME/.nvm/nvm.sh" ]; then
    set +euo pipefail
    . "$HOME/.nvm/nvm.sh"
    set -euo pipefail
  fi

  if ! check_installed npm; then
    echo "Skipping mcp-hub: npm not found (install nvm/node first)"
    return 0
  fi

  echo "Installing mcp-hub ${pkg_version} via npm..."
  npm install -g mcp-hub || return 1
}

install_mcp_hub
