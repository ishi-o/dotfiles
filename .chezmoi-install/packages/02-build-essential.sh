#!/usr/bin/env bash

pkg_name="build-essential"

install_build_essential() {
  if check_installed cc; then
    return 0
  fi

  if try_package_manager build-essential; then
    return 0
  fi

  echo "Warning: C compiler not found. Install build-essential or equivalent via your package manager." >&2
  return 0
}

install_build_essential
