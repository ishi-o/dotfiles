#!/usr/bin/env bash

pkg_name="uv"

install_uv() {
  if check_installed uv; then
    return 0
  fi

  echo "Installing uv..."

  if [ "$os" = "windows" ]; then
    local temp_dir="/tmp/uv.$$"
    mkdir -p "$temp_dir" || return 1
    download_extract \
      "https://github.com/astral-sh/uv/releases/latest/download/uv-x86_64-pc-windows-msvc.zip" \
      "$temp_dir" || {
      rm -rf "$temp_dir"
      return 1
    }
    mkdir -p "$HOME/.local/bin" || return 1
    cp "$temp_dir/uv.exe" "$HOME/.local/bin/uv.exe" || {
      rm -rf "$temp_dir"
      return 1
    }
    rm -rf "$temp_dir"
  else
    curl -LsSf https://astral.sh/uv/install.sh | sh
  fi

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

  local python_shim="$HOME/.local/bin/python"
  local python3_shim="$HOME/.local/bin/python3"
  if [ ! -e "$python_shim" ]; then
    cat > "$python_shim" << 'SHIM'
#!/bin/sh
exec uv run --no-project python "$@"
SHIM
    chmod +x "$python_shim"
  fi
  if [ ! -e "$python3_shim" ]; then
    cat > "$python3_shim" << 'SHIM'
#!/bin/sh
exec uv run --no-project python3 "$@"
SHIM
    chmod +x "$python3_shim"
  fi
}

install_uv
