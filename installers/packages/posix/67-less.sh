#!/usr/bin/env bash

pkg_name="less"

install_less() {
  if check_installed less; then
    return 0
  fi

  try_package_manager "$pkg_name"
}

install_less
