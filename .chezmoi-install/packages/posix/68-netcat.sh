#!/usr/bin/env bash

pkg_name="netcat-openbsd"

install_netcat() {
  if check_installed nc; then
    return 0
  fi

  try_package_manager "$pkg_name"
}

install_netcat
