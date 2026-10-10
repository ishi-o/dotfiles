#!/usr/bin/env bash

install_cc_switch_completions() {
  local shell=""
  case "${SHELL:-}" in
  *zsh) shell="zsh" ;;
  *bash) shell="bash" ;;
  *)
    echo "Warning: Skipping cc-switch completions: unsupported shell" >&2
    return 0
    ;;
  esac

  if ! command -v cc-switch >/dev/null 2>&1; then
    echo "Warning: Skipping cc-switch completions: cc-switch not found" >&2
    return 0
  fi

  if cc-switch completions install --shell "$shell"; then
    return 0
  fi

  local target_dir
  if [ "$shell" = "zsh" ]; then
    target_dir="${XDG_DATA_HOME:-$HOME/.local/share}/zsh/site-functions"
  else
    target_dir="${XDG_DATA_HOME:-$HOME/.local/share}/bash-completion/completions"
  fi

  if ! mkdir -p "$target_dir"; then
    echo "Warning: Could not create $target_dir" >&2
    return 0
  fi

  local completion_tmp
  completion_tmp="$(mktemp "$target_dir/.cc-switch.XXXXXX")" || {
    echo "Warning: Could not create a temporary cc-switch completion file" >&2
    return 0
  }

  if ! cc-switch completions "$shell" >"$completion_tmp" || [ ! -s "$completion_tmp" ]; then
    echo "Warning: Could not generate cc-switch completions" >&2
    rm -f "$completion_tmp"
    return 0
  fi

  if ! chmod 0644 "$completion_tmp"; then
    rm -f "$completion_tmp"
    return 0
  fi

  if [ "$shell" = "zsh" ]; then
    mv "$completion_tmp" "$target_dir/_cc-switch" || rm -f "$completion_tmp"
  else
    mv "$completion_tmp" "$target_dir/cc-switch" || rm -f "$completion_tmp"
  fi
}

install_cc_switch_completions
