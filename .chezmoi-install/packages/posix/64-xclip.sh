#!/usr/bin/env bash

pkg_name="xclip"

install_xclip() {
  if check_installed xclip; then
    return 0
  fi

  if [ "$is_wsl" != "true" ]; then
    return 0
  fi

  try_package_manager xclip
}

install_xclip
