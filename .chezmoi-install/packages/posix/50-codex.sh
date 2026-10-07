#!/usr/bin/env bash

pkg_name="codex"
pkg_version="${CODEX_VERSION:-latest}"

install_codex() {
  if check_installed codex; then
    return 0
  fi

  if ! check_installed pnpm; then
    echo "Skipping codex: pnpm not found (install pnpm first)"
    return 0
  fi

  echo "Installing codex ${pkg_version} via pnpm..."
  pnpm add -g @openai/codex || return 1
}

install_codex
