#!/usr/bin/env bash

pkg_name="clipboard-tools"

install_clipboard_tools() {
  if [ "$os" != "linux" ]; then
    return 0
  fi

  if ! check_installed wl-clipboard; then
    try_package_manager wl-clipboard ||
      echo "Warning: Could not install wl-clipboard automatically. Install it manually if needed." >&2
  fi

  if [ "$is_wsl" = "true" ] && ! check_installed xclip; then
    try_package_manager xclip ||
      echo "Warning: Could not install xclip automatically. Install it manually if needed." >&2
  fi
}

install_clipboard_tools
