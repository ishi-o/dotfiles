#!/usr/bin/env bash

pkg_name="cc"

install_cc() {
  if check_installed cc; then
    return 0
  fi

  if [ "$pkg_manager" = "apt" ] && [ "$has_sudo" = "true" ]; then
    install_via_apt build-essential || return 1
  fi
}

install_cc
