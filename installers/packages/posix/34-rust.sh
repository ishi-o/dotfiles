#!/usr/bin/env bash

pkg_name="rust"
pkg_version="stable"

install_rust() {
  if check_installed cargo; then
    echo "Rust is already installed ($(cargo --version))"
    return 0
  fi

  if check_installed rustup; then
    echo "rustup is already installed, updating..."
    rustup update
    return 0
  fi

  echo "Installing Rust via rustup..."

  if [ "$os" = "windows" ]; then
    local installer="/tmp/rustup-init.exe.$$"
    curl_download -o "$installer" "https://win.rustup.rs/x86_64" || return 1
    "$installer" -y --no-modify-path
    local installer_status=$?
    rm -f "$installer"
    return "$installer_status"
  fi

  curl_download --proto '=https' --tlsv1.2 https://sh.rustup.rs | sh -s -- -y

  if [ -f "$CARGO_HOME/env" ]; then
    source "$CARGO_HOME/env"
  fi

  echo "Rust installed successfully"
}

install_rust
