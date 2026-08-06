#!/usr/bin/env bash

install_fcitx5() {
  if [ "$is_wsl" != "true" ]; then
    echo "Skipping fcitx5: WSL was not detected"
    return 0
  fi

  if check_installed fcitx5; then
    echo "fcitx5 is already installed"
    return 0
  fi

  if try_package_manager fcitx5 fcitx5-chinese-addons; then
    echo "fcitx5 and Chinese input support installed"
    return 0
  fi

  echo "Warning: Could not install fcitx5 automatically. Install fcitx5 and fcitx5-chinese-addons manually if needed." >&2
  return 0
}

install_fcitx5
