#!/usr/bin/env bash

pkg_name="libksba"
pkg_version="${LIBKSBA_VERSION:-1.6.6}"

install_libksba() {
  if check_installed libksba-dev; then
    return 0
  fi

  if try_package_manager libksba-dev; then
    return 0
  fi

  install_gnu_tool "$pkg_name" "$pkg_version" \
    "https://gnupg.org/ftp/gcrypt/libksba/libksba-${pkg_version}.tar.bz2"
}

install_libksba
