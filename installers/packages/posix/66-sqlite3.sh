#!/usr/bin/env bash

pkg_name="sqlite"
pkg_version="${SQLITE_VERSION:-3.50.4}"

install_sqlite() {
  if check_installed sqlite3; then
    return 0
  fi

  if try_package_manager sqlite3; then
    return 0
  fi

  local source_version="${pkg_version//./_}"
  install_gnu_tool "$pkg_name-autoconf" "$source_version" \
    "https://www.sqlite.org/2025/sqlite-autoconf-${source_version}.tar.gz"
}

install_sqlite
