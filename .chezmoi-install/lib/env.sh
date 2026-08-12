#!/usr/bin/env bash
# Environment detection and configuration

# User-local installation directory
export USR_HOME="${USR_HOME:-$HOME/usr/local}"

# XDG-style configuration and data locations.
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"

# mise configuration, tool data, cache, and state follow XDG conventions.
export MISE_CONFIG_DIR="${MISE_CONFIG_DIR:-$XDG_CONFIG_HOME/mise}"
export MISE_DATA_DIR="${MISE_DATA_DIR:-$XDG_DATA_HOME/mise}"
export MISE_CACHE_DIR="${MISE_CACHE_DIR:-$XDG_CACHE_HOME/mise}"
export MISE_STATE_DIR="${MISE_STATE_DIR:-$XDG_STATE_HOME/mise}"
export MISE_INSTALL_PATH="${MISE_INSTALL_PATH:-$USR_HOME/mise/bin/mise}"

# Keep tool configuration and mutable package data out of $HOME.
export CODEX_HOME="${CODEX_HOME:-$XDG_CONFIG_HOME/codex}"
export CLAUDE_CONFIG_DIR="${CLAUDE_CONFIG_DIR:-$XDG_CONFIG_HOME/claude}"
export GH_CONFIG_DIR="${GH_CONFIG_DIR:-$XDG_CONFIG_HOME/gh}"
export NVM_DIR="${NVM_DIR:-$XDG_DATA_HOME/nvm}"
export GOPATH="${GOPATH:-$XDG_DATA_HOME/go}"
export GOCACHE="${GOCACHE:-$XDG_CACHE_HOME/go-build}"
export CARGO_HOME="${CARGO_HOME:-$XDG_DATA_HOME/cargo}"
export RUSTUP_HOME="${RUSTUP_HOME:-$XDG_DATA_HOME/rustup}"
export FZF_HOME="${FZF_HOME:-$XDG_DATA_HOME/fzf}"
export NPM_CONFIG_USERCONFIG="${NPM_CONFIG_USERCONFIG:-$XDG_CONFIG_HOME/npm/npmrc}"
export NPM_CONFIG_CACHE="${NPM_CONFIG_CACHE:-$XDG_CACHE_HOME/npm}"

# Detect operating system (darwin, linux, etc.)
os="$(uname | tr '[:upper:]' '[:lower:]')"
export os

# Detect architecture and normalize to common names
arch="$(uname -m)"
[ "$arch" = "x86_64" ] && arch=amd64
export arch

# Detect Windows Subsystem for Linux.
is_wsl=false
case "$(uname -r 2>/dev/null)" in
  *microsoft*|*Microsoft*|*WSL*) is_wsl=true ;;
esac
[ -n "${WSL_DISTRO_NAME:-}" ] && is_wsl=true
export is_wsl

# Detect available package manager
pkg_manager=""
if command -v apt-get >/dev/null 2>&1; then
  pkg_manager="apt"
fi
export pkg_manager

# Check if sudo is available (needed for package manager)
has_sudo=false
if [ "$pkg_manager" != "" ] && command -v sudo >/dev/null 2>&1; then
  has_sudo=true
fi
export has_sudo

# Add user bin to PATH
export PATH="$USR_HOME/mise/bin:$USR_HOME/bin:$USR_HOME/nvim/bin:$HOME/.local/bin:$FZF_HOME/bin:$CARGO_HOME/bin:$GOPATH/bin:$PATH"

# Ensure required directories exist
mkdir -p "$USR_HOME/src" || exit 1
mkdir -p "$HOME/.local/bin" || exit 1
mkdir -p "$XDG_CONFIG_HOME" "$XDG_DATA_HOME" "$XDG_CACHE_HOME" "$XDG_STATE_HOME" \
  "$MISE_CONFIG_DIR" "$MISE_DATA_DIR" "$MISE_CACHE_DIR" "$MISE_STATE_DIR" \
  "$CODEX_HOME" "$CLAUDE_CONFIG_DIR" "$GH_CONFIG_DIR" "$NVM_DIR" "$GOPATH" \
  "$CARGO_HOME" "$RUSTUP_HOME" "$XDG_CONFIG_HOME/npm" "$NPM_CONFIG_CACHE" || exit 1
