#!/usr/bin/env bash

pkg_name="python3"

install_python3() {
  if check_installed python3 && python3 -m venv --help >/dev/null 2>&1; then
    return 0
  fi

  # Install python3 if missing
  if ! check_installed python3; then
    if try_package_manager python3 python3-pip; then
      :
    else
      echo "Warning: python3 not installed. Install it via your package manager." >&2
      return 0
    fi
  fi

  # Install python3-venv explicitly (often missing on pre-installed python3)
  if ! python3 -m venv --help >/dev/null 2>&1; then
    if try_package_manager python3-venv; then
      :
    else
      echo "Warning: python3-venv not available. Some tools may fail to install." >&2
    fi
  fi
}

install_python3
