#!/usr/bin/env bash

pkg_name="go"
pkg_version="${GO_VERSION:-latest}"

install_go() {
  case "$os" in
  darwin|linux)
    ;;
  *)
    echo "Unsupported operating system for Go: $os"
    return 0
    ;;
  esac

  local target_arch="$arch"
  case "$target_arch" in
  amd64|arm64)
    ;;
  aarch64)
    target_arch="arm64"
    ;;
  *)
    echo "Unsupported architecture for Go: $target_arch"
    return 1
    ;;
  esac

  local go_root="$USR_HOME/go"
  if [ -x "$go_root/bin/go" ]; then
    echo "Go is already installed at $go_root"
    return 0
  fi

  if [ -e "$go_root" ]; then
    echo "Error: Go installation directory already exists without a Go binary: $go_root" >&2
    return 1
  fi

  local version="$pkg_version"
  if [ "$version" = "latest" ]; then
    version="$(curl -fsSL 'https://go.dev/VERSION?m=text' | sed -n '1p')" || return 1
  fi
  version="${version#go}"

  local archive="go${version}.${os}-${target_arch}.tar.gz"
  local temp_dir="/tmp/go-install.$$"
  local archive_path="$temp_dir/$archive"
  local url="https://go.dev/dl/$archive"

  mkdir -p "$temp_dir" || return 1
  curl -fL "$url" -o "$archive_path" || {
    rm -rf "$temp_dir"
    return 1
  }
  tar -xzf "$archive_path" -C "$temp_dir" || {
    rm -rf "$temp_dir"
    return 1
  }
  [ -x "$temp_dir/go/bin/go" ] || {
    echo "Error: Go binary was not found in $archive" >&2
    rm -rf "$temp_dir"
    return 1
  }

  mkdir -p "$USR_HOME" || {
    rm -rf "$temp_dir"
    return 1
  }
  mv "$temp_dir/go" "$go_root" || {
    rm -rf "$temp_dir"
    return 1
  }
  rm -rf "$temp_dir"
  echo "Go ${version} installed at $go_root"
}

install_go
