#!/usr/bin/env bash

pkg_name="jdk"

install_jdk() {
  if check_installed java; then
    return 0
  fi

  if try_package_manager openjdk-21-jdk; then
    return 0
  fi

  echo "Warning: jdk not installed. Install it via your package manager." >&2
  return 0
}

install_jdk
