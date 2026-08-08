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
  # uv python install creates python3.X executables in ~/.local/bin.
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

  # Create python3 shim that delegates to uv.
  # This makes `python3` respect `uv python pin --global <version>`.
  # Without the shim, `uv python pin` only affects `uv run`, not bare `python3`.
  local python3_shim="$HOME/.local/bin/python3"
  if [ ! -e "$python3_shim" ]; then
    cat > "$python3_shim" << 'SHIM'
#!/bin/sh
exec uv run --no-project python3 "$@"
SHIM
    chmod +x "$python3_shim"
  fi
}

install_uv
