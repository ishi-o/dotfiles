#!/usr/bin/env bash

generate_rust_zsh_completions() {
  local zfunc_dir="${XDG_CONFIG_HOME:-$HOME/.config}/zfunc"
  local rustup_cmd=""
  local rustup_path="${CARGO_HOME:-$HOME/.local/share/cargo}/bin/rustup"
  local rustup_tmp cargo_tmp

  if [ -x "$rustup_path" ]; then
    rustup_cmd="$rustup_path"
  elif command -v rustup >/dev/null 2>&1; then
    rustup_cmd="$(command -v rustup)"
  else
    echo "Warning: Skipping Rust zsh completions: rustup not found" >&2
    return 0
  fi

  if ! mkdir -p "$zfunc_dir"; then
    echo "Warning: Could not create $zfunc_dir" >&2
    return 0
  fi

  rustup_tmp="$(mktemp "$zfunc_dir/.rustup.XXXXXX")" || {
    echo "Warning: Could not create a temporary rustup completion file" >&2
    return 0
  }
  cargo_tmp="$(mktemp "$zfunc_dir/.cargo.XXXXXX")" || {
    echo "Warning: Could not create a temporary cargo completion file" >&2
    rm -f "$rustup_tmp"
    return 0
  }

  if ! "$rustup_cmd" completions zsh >"$rustup_tmp" ||
    ! "$rustup_cmd" completions zsh cargo >"$cargo_tmp" ||
    [ ! -s "$rustup_tmp" ] ||
    [ ! -s "$cargo_tmp" ]; then
    echo "Warning: Could not generate Rust zsh completions" >&2
    rm -f "$rustup_tmp" "$cargo_tmp"
    return 0
  fi

  if ! chmod 0644 "$rustup_tmp" "$cargo_tmp" ||
    ! mv "$rustup_tmp" "$zfunc_dir/_rustup" ||
    ! mv "$cargo_tmp" "$zfunc_dir/_cargo"; then
    echo "Warning: Could not install Rust zsh completions in $zfunc_dir" >&2
    rm -f "$rustup_tmp" "$cargo_tmp"
    return 0
  fi
}

generate_rust_zsh_completions
