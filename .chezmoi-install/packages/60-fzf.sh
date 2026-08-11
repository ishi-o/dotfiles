#!/usr/bin/env bash

pkg_name="fzf"
pkg_version="latest"

install_fzf() {
  if check_installed fzf; then
    return 0
  fi

  # Try package manager first
  if try_package_manager fzf; then
    return 0
  fi

  # Fall back to git clone installation
  echo "Installing fzf..."

  if [ ! -d "$FZF_HOME" ]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git "$FZF_HOME" || return 1
  fi

  "$FZF_HOME/install" --all --xdg
}

install_fzf
