#!/usr/bin/env bash

pkg_name="libgcrypt"
pkg_version="${LIBGCRYPT_VERSION:-1.10.3}"

install_libgcrypt() {
  if check_installed libgcrypt20-dev; then
    return 0
  fi

  if try_package_manager libgcrypt20-dev; then
    return 0
  fi

  install_gnu_tool "$pkg_name" "$pkg_version" \
    "https://gnupg.org/ftp/gcrypt/libgcrypt/libgcrypt-${pkg_version}.tar.bz2"
}

install_libgcrypt
