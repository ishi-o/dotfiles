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
  darwin|linux|windows)
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
  windows:amd64|windows:x86_64)
    target="x86_64-pc-windows-msvc"
    ;;
  *)
    echo "Unsupported architecture for ripgrep: $os/$arch"
    return 1
    ;;
  esac

  local version="${pkg_version#v}"
  local archive_name="ripgrep-${version}-${target}"
  local archive_extension="tar.gz"
  [ "$os" = "windows" ] && archive_extension="zip"
  local url="https://github.com/BurntSushi/ripgrep/releases/download/${version}/${archive_name}.${archive_extension}"
  local binary="rg"
  [ "$os" = "windows" ] && binary="rg.exe"

  download_binary \
    "$pkg_name" "$version" "$url" "$binary" \
    "$HOME/.local/bin/$binary"
}

install_ripgrep
