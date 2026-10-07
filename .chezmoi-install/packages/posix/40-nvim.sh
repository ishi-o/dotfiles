#!/usr/bin/env bash

pkg_name="nvim"
pkg_version="${NVIM_VERSION:-nightly}"

install_nvim() {
  if check_installed nvim; then
    return 0
  fi

  echo "Installing nvim ${pkg_version}..."

  local nvim_archive
  case "$os:$arch" in
    darwin:amd64 | darwin:x86_64)
      nvim_archive="nvim-macos-x86_64.tar.gz"
      ;;
    darwin:arm64 | darwin:aarch64)
      nvim_archive="nvim-macos-arm64.tar.gz"
      ;;
    linux:amd64 | linux:x86_64)
      nvim_archive="nvim-linux-x86_64.tar.gz"
      ;;
    linux:arm64 | linux:aarch64)
      nvim_archive="nvim-linux-arm64.tar.gz"
      ;;
    windows:amd64 | windows:x86_64)
      nvim_archive="nvim-win64.zip"
      ;;
    *)
      echo "Error: Unsupported Neovim platform: $os/$arch"
      return 1
      ;;
  esac

  rm -rf "$USR_HOME/opt/nvim"
  mkdir -p "$USR_HOME/opt/nvim" || return 1

  download_extract \
    "https://github.com/neovim/neovim/releases/download/${pkg_version}/${nvim_archive}" \
    "$USR_HOME/opt/nvim" \
    --strip-components=1 || {
    rm -rf "$USR_HOME/opt/nvim"
    return 1
  }

  if [ "$os" != "windows" ]; then
    mkdir -p "$USR_HOME/bin" || return 1
    ln -sf "$USR_HOME/opt/nvim/bin/nvim" "$USR_HOME/bin/nvim" || return 1
  fi
}

install_nvim
