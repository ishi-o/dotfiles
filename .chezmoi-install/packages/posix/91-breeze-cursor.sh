#!/usr/bin/env bash

pkg_name="breeze-cursor-theme"

install_breeze_cursor() {
  if [ "$os" != "linux" ]; then
    echo "Skipping breeze-cursor-theme: only supported on Linux"
    return 0
  fi

  if [ -d /usr/share/icons/breeze_cursors ] || [ -d "$XDG_DATA_HOME/icons/breeze_cursors" ]; then
    echo "breeze-cursor-theme is already installed"
    return 0
  fi

  if try_package_manager breeze-cursor-theme; then
    return 0
  fi

  echo "Warning: Could not install breeze-cursor-theme automatically. Install it manually if needed." >&2
  return 0
}

install_breeze_cursor
