#!/usr/bin/env bash

pkg_name="unzip"

install_unzip() {
  if check_installed unzip; then
    return 0
  fi

  if try_package_manager unzip; then
    return 0
  fi

  echo "Warning: unzip not installed. Install it via your package manager." >&2
  return 0
}

install_unzip
