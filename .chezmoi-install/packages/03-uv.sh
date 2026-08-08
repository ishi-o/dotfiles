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
  # uv python install creates python3.X symlinks in ~/.local/bin.
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

  # Create unversioned python3 symlink pointing to the default version.
  # uv only creates versioned symlinks (python3.14, python3.13), not python3.
  local python3_link="$HOME/.local/bin/python3"
  if [ ! -L "$python3_link" ] && [ ! -e "$python3_link" ] && check_installed python3.14; then
    ln -s python3.14 "$python3_link"
  fi
}

install_uv
