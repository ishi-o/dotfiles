#!/usr/bin/env bash

pkg_name="gh"
pkg_version="${GH_VERSION:-2.74.0}"

install_gh() {
  if check_installed gh; then
    return 0
  fi

  # Try the system package manager first.
  if try_package_manager gh; then
    return 0
  fi

  case "$os" in
  darwin|linux)
    ;;
  *)
    echo "Unsupported operating system for gh: $os"
    return 0
    ;;
  esac

  local target
  case "$os:$arch" in
  darwin:amd64)
    target="amd64"
    ;;
  darwin:arm64)
    target="arm64"
    ;;
  linux:amd64)
    target="amd64"
    ;;
  linux:arm64|linux:aarch64)
    target="arm64"
    ;;
  *)
    echo "Unsupported architecture for gh: $os/$arch"
    return 1
    ;;
  esac

  local version="${pkg_version#v}"
  local release_os="$os"
  if [[ "$os" == "darwin" ]]; then
    release_os="macOS"
  fi
  local archive_name="gh_${version}_${release_os}_${target}"
  local url="https://github.com/cli/cli/releases/download/v${version}/${archive_name}.tar.gz"

  download_binary \
    "$pkg_name" "$version" "$url" "bin/gh" "$HOME/.local/bin/gh"
}

install_gh
