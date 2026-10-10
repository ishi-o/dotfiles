#!/usr/bin/env bash

pkg_name="claude"
pkg_version="${CLAUDE_VERSION:-latest}"

install_claude() {
  if check_installed claude; then
    return 0
  fi

  if ! check_installed pnpm; then
    echo "Skipping claude: pnpm not found (install pnpm first)"
    return 0
  fi

  echo "Installing claude ${pkg_version} via pnpm..."
  pnpm add -g @anthropic-ai/claude-code || return 1
}

install_claude
