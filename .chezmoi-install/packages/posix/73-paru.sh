#!/usr/bin/env bash

pkg_name="paru"

is_arch_family() {
  case "$system_release" in
  arch | manjaro | endeavouros | garuda | artix | cachyos) return 0 ;;
  *) return 1 ;;
  esac
}

install_paru() {
  if [ "$os" != "linux" ] || ! is_arch_family; then
    echo "Skipping paru: only supported on Arch-based systems"
    return 0
  fi

  if check_installed paru; then
    return 0
  fi

  if ! command -v makepkg >/dev/null 2>&1 || ! command -v git >/dev/null 2>&1; then
    echo "Warning: makepkg or git not found; install base-devel and git first." >&2
    return 0
  fi

  echo "Installing paru from AUR..."

  local build_dir="$SRC_HOME/paru-bin"
  rm -rf "$build_dir"
  mkdir -p "$build_dir" || return 0

  if ! download_extract "https://aur.archlinux.org/cgit/aur.git/snapshot/paru-bin.tar.gz" "$build_dir" --strip-components=1; then
    echo "Warning: Could not download paru-bin sources from AUR." >&2
    rm -rf "$build_dir"
    return 0
  fi

  if ! (cd "$build_dir" && makepkg -si --noconfirm --needed); then
    echo "Warning: Could not build paru from AUR." >&2
    rm -rf "$build_dir"
    return 0
  fi

  rm -rf "$build_dir"
}

install_paru
