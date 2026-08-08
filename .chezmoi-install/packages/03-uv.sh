#!/usr/bin/env bash

pkg_name="uv"

install_uv() {
  if check_installed uv; then
    return 0
  fi

  echo "Installing uv..."

  curl -LsSf https://astral.sh/uv/install.sh | sh

  if ! check_installed uv; then
    echo "Warning: uv installed but not found in PATH" >&2
    return 0
  fi

  # Install Python versions via uv.
  # uv python install places python3.X and python3 symlinks in ~/.local/bin.
  # - 3.14: default python3 for general use
  # - 3.13: needed by Mason packages that require python<3.14
  #   (e.g. nginx-language-server: Requires-Python >=3.9,<3.14)
  local py_versions=("3.14" "3.13")
  for ver in "${py_versions[@]}"; do
    if ! check_installed "python${ver}"; then
      echo "Installing Python ${ver} via uv..."
      uv python install "${ver}"
    fi
  done
}

install_uv
