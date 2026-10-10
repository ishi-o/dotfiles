#!/usr/bin/env bash

pkg_name="codegraph"
pkg_version="${CODEGRAPH_VERSION:-latest}"

install_codegraph() {
  if check_installed codegraph; then
    return 0
  fi

  if ! check_installed pnpm; then
    echo "Skipping codegraph: pnpm not found (install pnpm first)"
    return 0
  fi

  echo "Installing codegraph ${pkg_version} via pnpm..."
  pnpm add -g @colbymchenry/codegraph || return 1
}

install_codegraph
