#!/usr/bin/env bash

pkg_name="serena"

install_serena() {
  if check_installed serena; then
    return 0
  fi

  if ! check_installed uv; then
    echo "Skipping serena: uv not found (install uv first)"
    return 0
  fi

  echo "Installing serena via uv..."
  uv tool install -p 3.13 serena-agent || return 1
}

install_serena
