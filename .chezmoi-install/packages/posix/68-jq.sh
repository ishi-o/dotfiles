#!/usr/bin/env bash

pkg_name="jq"

install_jq() {
  if check_installed jq; then
    return 0
  fi

  try_package_manager "$pkg_name"
}

install_jq
