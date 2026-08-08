#!/usr/bin/env bash

pkg_name="python3"

install_python3() {
  if check_installed python3; then
    return 0
  fi

  if try_package_manager python3 python3-pip python3-venv; then
    return 0
  fi

  echo "Warning: python3 not installed. Install it via your package manager." >&2
  return 0
}

install_python3
