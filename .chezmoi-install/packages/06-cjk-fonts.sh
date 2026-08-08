#!/usr/bin/env bash

pkg_name="cjk-fonts"

install_cjk_fonts() {
  # Check if any CJK font is available
  if fc-list :lang=zh 2>/dev/null | grep -q .; then
    return 0
  fi

  if try_package_manager fonts-noto-cjk; then
    return 0
  fi

  echo "Warning: No CJK font installed. Chinese characters may not render." >&2
  return 0
}

install_cjk_fonts
