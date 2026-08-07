#!/usr/bin/env bash

pkg_name="kitty"
pkg_version="latest"

install_kitty() {
  case "$os" in
  darwin|linux)
    ;;
  *)
    echo "Unsupported operating system for kitty: $os"
    return 0
    ;;
  esac

  if check_installed kitty; then
    return 0
  fi

  echo "Installing kitty ${pkg_version}..."
  curl -fL https://sw.kovidgoyal.net/kitty/installer.sh |
    sh /dev/stdin launch=n "dest=$USR_HOME" || return 1

  if ! check_installed kitty; then
    echo "Error: kitty was not installed" >&2
    return 1
  fi
}

install_kitty
