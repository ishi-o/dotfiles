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

  local kitty_app="$HOME/.local/kitty.app"
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
    mkdir -p "$HOME/.local/bin" || return 1
    curl -fL https://sw.kovidgoyal.net/kitty/installer.sh |
      sh /dev/stdin launch=n "dest=$kitty_app" || return 1
  fi

  if [ ! -x "$kitty_bin" ]; then
    echo "Error: kitty was not installed at $kitty_bin" >&2
    return 1
  fi

  mkdir -p "$HOME/.local/bin" || return 1
  ln -sf "$kitty_bin" "$HOME/.local/bin/kitty" || return 1
  if [ -x "$kitten_bin" ]; then
    ln -sf "$kitten_bin" "$HOME/.local/bin/kitten" || return 1
  fi
}

install_kitty
