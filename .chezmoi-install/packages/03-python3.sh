#!/usr/bin/env bash

pkg_name="python3"

install_python3() {
  if ! check_installed python3; then
    if try_package_manager python3 python3-pip; then
      :
    else
      echo "Warning: python3 not installed. Install it via your package manager." >&2
      return 0
    fi
  fi

  # Ensure python3-venv is installed (provides ensurepip for venv creation with pip).
  # python3 -m venv may succeed without it but produce venvs lacking pip.
  if [ "$pkg_manager" = "apt" ]; then
    if ! dpkg -l python3-venv 2>/dev/null | grep -q "^ii"; then
      install_via_apt python3-venv || echo "Warning: python3-venv not available. Some tools may fail." >&2
    fi
  fi
}

install_python3
