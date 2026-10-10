#!/usr/bin/env bash

pkg_name="openssh-client"

install_openssh() {
  if check_installed ssh; then
    return 0
  fi

  try_package_manager "$pkg_name"
}

install_openssh
