#!/usr/bin/env bash

pkg_name="nvim"
pkg_version="${NVIM_VERSION:-nightly}"

install_nvim() {
  if check_installed nvim; then
    return 0
  fi

  echo "Installing nvim ${pkg_version}..."

  # Determine the appropriate binary based on OS and architecture.
  local nvim_archive
  case "$os:$arch" in
  darwin:amd64|darwin:x86_64)
    nvim_archive="nvim-macos-x86_64.tar.gz"
    ;;
  darwin:arm64|darwin:aarch64)
    nvim_archive="nvim-macos-arm64.tar.gz"
    ;;
  linux:amd64|linux:x86_64)
    nvim_archive="nvim-linux-x86_64.tar.gz"
    ;;
  linux:arm64|linux:aarch64)
    nvim_archive="nvim-linux-arm64.tar.gz"
    ;;
  windows:amd64|windows:x86_64)
    nvim_archive="nvim-win64.zip"
    ;;
  *)
    echo "Error: Unsupported Neovim platform: $os/$arch"
    return 1
    ;;
  esac

  local temp_dir="/tmp/nvim.$$"
  mkdir -p "$temp_dir" || return 1

  download_extract \
    "https://github.com/neovim/neovim/releases/download/${pkg_version}/${nvim_archive}" \
    "$temp_dir" || {
    rm -rf "$temp_dir"
    return 1
  }

  rm -rf "$USR_HOME/nvim"
  mkdir -p "$USR_HOME" || return 1
  if [ "$os" = "windows" ]; then
    mv "$temp_dir/nvim-win64" "$USR_HOME/nvim" || {
      rm -rf "$temp_dir"
      return 1
    }
  else
    # Remove extended attributes (macOS only)
    if [[ "$os" == "darwin" ]]; then
      xattr -c "$temp_dir/$nvim_archive" || return 1
    fi
    mkdir -p "$USR_HOME/nvim" || return 1
    tar -xzf "$temp_dir/$nvim_archive" --strip-components=1 -C "$USR_HOME/nvim" || {
      rm -rf "$temp_dir"
      return 1
    }
  fi
  rm -rf "$temp_dir"
}

install_nvim
