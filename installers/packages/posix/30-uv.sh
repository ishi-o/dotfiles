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
    curl_download https://astral.sh/uv/install.sh | sh
  fi

  if ! check_installed uv; then
    echo "Warning: uv installed but not found in PATH" >&2
    return 0
  fi
}

install_uv
