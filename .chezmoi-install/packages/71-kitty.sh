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

  local kitty_app="$USR_HOME/kitty.app"
  local kitty_bin
  local kitten_bin

  if [[ "$os" == "darwin" ]]; then
    kitty_bin="$kitty_app/Contents/MacOS/kitty"
    kitten_bin="$kitty_app/Contents/MacOS/kitten"
  else
    kitty_bin="$kitty_app/bin/kitty"
    kitten_bin="$kitty_app/bin/kitten"
  fi

  if ! check_installed kitty && [ ! -x "$kitty_bin" ]; then
    echo "Installing kitty ${pkg_version}..."
    curl -fL https://sw.kovidgoyal.net/kitty/installer.sh |
      sh /dev/stdin launch=n "dest=$USR_HOME" || return 1
  fi

  if [ ! -x "$kitty_bin" ]; then
    echo "Error: kitty was not installed at $kitty_bin" >&2
    return 1
  fi

  mkdir -p "$USR_HOME/bin" || return 1
  cp -f "$kitty_bin" "$USR_HOME/bin/kitty" || return 1
  if [ -x "$kitten_bin" ]; then
    cp -f "$kitten_bin" "$USR_HOME/bin/kitten" || return 1
  fi
}

install_kitty
