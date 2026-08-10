#!/usr/bin/env bash

pkg_name="zsh-completions"

install_zsh_completions() {
  local zfunc_dir="$HOME/.config/zfunc"
  local rustup_cmd=""
  local rustup_path="$HOME/.cargo/bin/rustup"

  if [ -x "$rustup_path" ]; then
    rustup_cmd="$rustup_path"
  elif command -v rustup >/dev/null 2>&1; then
    rustup_cmd="$(command -v rustup)"
  else
    echo "Skipping zsh completions: rustup not found"
    return 0
  fi

  mkdir -p "$zfunc_dir" || return 1

  local rustup_tmp
  local cargo_tmp
  rustup_tmp="$(mktemp "$zfunc_dir/.rustup.XXXXXX")" || return 1
  cargo_tmp="$(mktemp "$zfunc_dir/.cargo.XXXXXX")" || {
    rm -f "$rustup_tmp"
    return 1
  }

  if ! "$rustup_cmd" completions zsh >"$rustup_tmp" ||
    ! "$rustup_cmd" completions zsh cargo >"$cargo_tmp" ||
    [ ! -s "$rustup_tmp" ] ||
    [ ! -s "$cargo_tmp" ]; then
    echo "Warning: Could not generate Rust zsh completions" >&2
    rm -f "$rustup_tmp" "$cargo_tmp"
    return 0
  fi

  chmod 0644 "$rustup_tmp" "$cargo_tmp" || {
    rm -f "$rustup_tmp" "$cargo_tmp"
    return 1
  }
  mv "$rustup_tmp" "$zfunc_dir/_rustup" || return 1
  mv "$cargo_tmp" "$zfunc_dir/_cargo" || return 1
}

install_zsh_completions
