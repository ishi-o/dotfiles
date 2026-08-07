#!/usr/bin/env bash

pkg_name="ripgrep"
pkg_version="${RIPGREP_VERSION:-15.2.0}"

install_ripgrep() {
  if check_installed rg; then
    echo "ripgrep is already installed"
    return 0
  fi

  # Try the system package manager first.
  if try_package_manager ripgrep; then
    return 0
  fi

  case "$os" in
  darwin|linux)
    ;;
  *)
    echo "Unsupported operating system for ripgrep: $os"
    return 0
    ;;
  esac

  local target
  case "$os:$arch" in
  darwin:amd64)
    target="x86_64-apple-darwin"
    ;;
  darwin:arm64)
    target="aarch64-apple-darwin"
    ;;
  linux:amd64)
    target="x86_64-unknown-linux-musl"
    ;;
  linux:arm64|linux:aarch64)
    target="aarch64-unknown-linux-musl"
    ;;
  *)
    echo "Unsupported architecture for ripgrep: $os/$arch"
    return 1
    ;;
  esac

  local version="${pkg_version#v}"
  local archive_name="ripgrep-${version}-${target}"
  local url="https://github.com/BurntSushi/ripgrep/releases/download/${version}/${archive_name}.tar.gz"

  download_binary \
    "$pkg_name" "$version" "$url" "rg" "$HOME/.local/bin/rg"
}

install_ripgrep
