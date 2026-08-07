#!/usr/bin/env bash
# Environment detection and configuration

# User-local installation directory
export USR_HOME="${USR_HOME:-$HOME/usr/local}"

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

# Optional network proxy. Set PROXY_URL before running chezmoi to enable it.
if [ -n "${PROXY_URL:-}" ]; then
  export HTTP_PROXY="$PROXY_URL"
  export HTTPS_PROXY="$PROXY_URL"
  export ALL_PROXY="$PROXY_URL"
  export http_proxy="$PROXY_URL"
  export https_proxy="$PROXY_URL"
  export all_proxy="$PROXY_URL"
  export NO_PROXY="${NO_PROXY:-${no_proxy:-localhost,127.0.0.1,::1}}"
  export no_proxy="${no_proxy:-$NO_PROXY}"
fi

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
export PATH="$USR_HOME/bin:$HOME/.local/bin:$PATH"

# Ensure required directories exist
mkdir -p "$USR_HOME/src" || exit 1
mkdir -p "$HOME/.local/bin" || exit 1
