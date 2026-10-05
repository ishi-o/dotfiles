#!/usr/bin/env bash

pkg_name="vim"

install_vim() {
  if check_installed vim; then
    return 0
  fi

  if try_package_manager vim; then
    return 0
  fi

  echo "Warning: vim was not installed." >&2
  return 0
}

install_vim
