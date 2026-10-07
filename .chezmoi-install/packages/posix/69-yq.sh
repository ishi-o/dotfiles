#!/usr/bin/env bash

pkg_name="yq"

install_yq() {
  if check_installed yq; then
    return 0
  fi

  download_binary \
    "yq" \
    "latest" \
    "https://github.com/mikefarah/yq/releases/latest/download/yq_${os}_${arch}.tar.gz" \
    "yq_${os}_${arch}" \
    "$HOME/.local/bin/yq"
}

install_yq
