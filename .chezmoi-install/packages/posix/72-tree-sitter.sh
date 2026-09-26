#!/usr/bin/env bash

pkg_name="tree-sitter"
pkg_version="${TREE_SITTER_VERSION:-0.25.3}"

install_tree_sitter() {
  if check_installed tree-sitter; then
    return 0
  fi

  if ! check_installed cargo; then
    echo "Skipping tree-sitter: cargo not found (install rust first)"
    return 0
  fi

  echo "Installing tree-sitter ${pkg_version} via cargo..."
  cargo install tree-sitter-cli --version "^${pkg_version}" --root "$USR_HOME" || return 1
}

install_tree_sitter
