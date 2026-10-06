#!/usr/bin/env bash

pkg_name="cc-switch"

install_cc_switch() {
  if check_installed cc-switch; then
    return 0
  fi

  echo "Installing cc-switch..."
  CC_SWITCH_INSTALL_DIR="$HOME/.local/bin" CC_SWITCH_FORCE=1 \
    curl -fsSL https://github.com/SaladDay/cc-switch-cli/releases/latest/download/install.sh |
    bash
}

install_cc_switch
