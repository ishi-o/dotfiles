#!/usr/bin/env bash

pkg_name="kitty"
pkg_version="latest"

register_kitty_in_dock() {
  [ "$os" = "darwin" ] || return 0
  command -v defaults >/dev/null 2>&1 || return 0

  local kitty_app="$USR_HOME/kitty.app"
  [ -d "$kitty_app" ] || return 0

  # Avoid adding a second tile when this installer is run again.
  if defaults read com.apple.dock persistent-apps 2>/dev/null |
    grep -Fq "$kitty_app"; then
    return 0
  fi

  local dock_item
  dock_item="<dict><key>tile-data</key><dict><key>bundle-identifier</key><string>net.kovidgoyal.kitty</string><key>file-data</key><dict><key>_CFURLString</key><string>file://${kitty_app}/</string><key>_CFURLStringType</key><integer>15</integer></dict><key>file-label</key><string>kitty</string><key>file-type</key><integer>41</integer></dict><key>tile-type</key><string>file-tile</string></dict>"

  if defaults write com.apple.dock persistent-apps -array-add "$dock_item"; then
    killall Dock >/dev/null 2>&1 || true
  else
    echo "Warning: could not register kitty in the Dock" >&2
  fi
}

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

  case "$os" in
  darwin)
    kitty_bin="$kitty_app/Contents/MacOS/kitty"
    kitten_bin="$kitty_app/Contents/MacOS/kitten"
    ;;
  linux)
    kitty_bin="$kitty_app/bin/kitty"
    kitten_bin="$kitty_app/bin/kitten"
    ;;
  esac

  if check_installed kitty; then
    register_kitty_in_dock
    return 0
  fi

  if [ ! -x "$kitty_bin" ]; then
    echo "Installing kitty ${pkg_version}..."
    curl -fL https://sw.kovidgoyal.net/kitty/installer.sh |
      sh /dev/stdin launch=n "dest=$USR_HOME" || return 1
  fi

  if [ ! -x "$kitty_bin" ]; then
    echo "Error: kitty was not installed at $kitty_bin" >&2
    return 1
  fi

  # Keep the application bundle intact and expose its executables through the
  # user-local bin directory. This works for both the macOS bundle and Linux
  # layouts, and avoids moving binaries out of Kitty's installation folder.
  mkdir -p "$USR_HOME/bin" || return 1
  ln -sf "$kitty_bin" "$USR_HOME/bin/kitty" || return 1
  if [ -x "$kitten_bin" ]; then
    ln -sf "$kitten_bin" "$USR_HOME/bin/kitten" || return 1
  fi

  if ! check_installed kitty; then
    echo "Error: kitty was not installed" >&2
    return 1
  fi

  register_kitty_in_dock
}

install_kitty
