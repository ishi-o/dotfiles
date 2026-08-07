#!/usr/bin/env bash

pkg_name="consolas-ligaturized"
pkg_version="${CONSOLAS_LIGATURIZED_REF:-master}"
pkg_url="https://github.com/somq/consolas-ligaturized.git"

install_consolas_ligaturized() {
  local font_dir
  case "$os" in
  darwin)
    font_dir="$HOME/Library/Fonts"
    ;;
  linux)
    font_dir="$HOME/.local/share/fonts"
    ;;
  *)
    echo "Skipping ${pkg_name}: unsupported operating system: $os"
    return 0
    ;;
  esac

  # Skip if fonts are already installed
  if ls "$font_dir"/Consolasligaturizedv3*.ttf >/dev/null 2>&1; then
    return 0
  fi

  local src_dir="$USR_HOME/src/$pkg_name"
  if [ ! -d "$src_dir/.git" ]; then
    if [ -e "$src_dir" ]; then
      echo "Error: font source directory exists without a Git repository: $src_dir" >&2
      return 1
    fi
    echo "Downloading ${pkg_name} (${pkg_version})..."
    git clone --depth 1 --branch "$pkg_version" "$pkg_url" "$src_dir" || return 1
  fi

  local font_file
  local installed=false
  mkdir -p "$font_dir" || return 1
  for font_file in "$src_dir"/Consolasligaturizedv3*.ttf; do
    if [ ! -f "$font_file" ]; then
      continue
    fi
    cp -f "$font_file" "$font_dir/" || return 1
    installed=true
  done

  if [ "$installed" != true ]; then
    echo "Error: no Consolas ligaturized v3 fonts found in $src_dir" >&2
    return 1
  fi

  if [ "$os" = "linux" ] && command -v fc-cache >/dev/null 2>&1; then
    fc-cache -f "$font_dir" >/dev/null 2>&1 ||
      echo "Warning: could not refresh the font cache automatically" >&2
  fi

  echo "Installed Consolas ligaturized v3 fonts in $font_dir"
}

install_consolas_ligaturized
