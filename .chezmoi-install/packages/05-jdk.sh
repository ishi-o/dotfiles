#!/usr/bin/env bash

pkg_name="jdk"
pkg_version="${JDK_VERSION:-openjdk-21}"

install_jdk() {
  if [ ! -x "$MISE_INSTALL_PATH" ]; then
    echo "Warning: mise is not installed; skipping JDK installation." >&2
    return 0
  fi

  echo "Installing Java ${pkg_version} via mise..."
  if ! "$MISE_INSTALL_PATH" use --global "java@${pkg_version}"; then
    echo "Warning: JDK ${pkg_version} could not be installed via mise." >&2
    return 0
  fi

  if "$MISE_INSTALL_PATH" exec -- java --version >/dev/null 2>&1; then
    echo "Java ${pkg_version} is managed by mise."
  else
    echo "Warning: mise installed Java ${pkg_version}, but it could not be executed." >&2
  fi
  return 0
}

install_jdk
