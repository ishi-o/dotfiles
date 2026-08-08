#!/usr/bin/env bash

pkg_name="claude"
pkg_version="${CLAUDE_VERSION:-latest}"

install_claude() {
  if check_installed claude; then
    return 0
  fi

  if ! check_installed npm; then
    echo "Skipping claude: npm not found (install nvm/node first)"
    return 0
  fi

  echo "Installing claude ${pkg_version} via npm..."
  npm install -g @anthropic-ai/claude-code || return 1
}

install_claude
