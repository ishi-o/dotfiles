#!/usr/bin/env bash

pkg_name="kubectl"
pkg_version="stable"

install_kubectl() {
  local target="$HOME/.local/bin/kubectl"
  local binary="kubectl"
  if [ "$os" = "windows" ]; then
    target="$HOME/.local/bin/kubectl.exe"
    binary="kubectl.exe"
  fi

  if check_installed kubectl && [ -x "$target" ]; then
    return 0
  fi

  echo "Installing kubectl (latest stable)..."

  local stable_version
  stable_version=$(curl -L -s https://dl.k8s.io/release/stable.txt) || return 1

  local temp="${target}.tmp.$$"

  curl -L "https://dl.k8s.io/release/${stable_version}/bin/${os}/${arch}/${binary}" -o "$temp" || return 1
  chmod +x "$temp" || return 1
  mv "$temp" "$target" || return 1
}

install_kubectl
