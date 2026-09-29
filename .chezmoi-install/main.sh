#!/usr/bin/env bash
# Main orchestrator for package installation

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Global cleanup function for interrupted downloads
cleanup_temp_files() {
  # Clean up any temp files created by this process
  rm -f /tmp/*.tmp.$$
  rm -rf /tmp/*-*.$$
  rm -f "$HOME/.local/bin/"*.tmp.$$
}

# Set up trap to cleanup on exit, interrupt, or termination
trap cleanup_temp_files EXIT INT TERM

# Source libraries
source "$SCRIPT_DIR/lib/posix/env.sh"
source "$SCRIPT_DIR/lib/posix/helpers.sh"

confirm_install() {
  local prompt="$1"
  local answer

  printf '%s [Y/n] ' "$prompt"
  IFS= read -r answer || answer=""
  case "${answer:-y}" in
  n | N | no | No | NO) return 1 ;;
  *) return 0 ;;
  esac
}

commands_missing() {
  local command
  for command in "$@"; do
    command -v "$command" >/dev/null 2>&1 || return 0
  done
  return 1
}

category_enabled() {
  case "$1" in
  base)
    [ "$install_base" = "true" ]
    ;;
  runtimes)
    [ "$install_runtimes" = "true" ]
    ;;
  editor)
    [ "$install_editor" = "true" ]
    ;;
  ai)
    [ "$install_ai" = "true" ]
    ;;
  utilities)
    [ "$install_utilities" = "true" ]
    ;;
  operations)
    [ "$install_operations" = "true" ]
    ;;
  terminal)
    [ "$install_terminal" = "true" ]
    ;;
  input)
    [ "$install_input" = "true" ]
    ;;
  *)
    return 2
    ;;
  esac
}

echo "==> Starting package installation"

install_base=true
if commands_missing zsh cc unzip m4 autoconf automake pkg-config openssl gpg &&
  ! confirm_install "Install missing base environment and build tools?"; then
  install_base=false
fi

install_runtimes=true
if commands_missing uv mise node luajit cargo &&
  ! confirm_install "Install missing language runtimes?"; then
  install_runtimes=false
fi

install_editor=true
if commands_missing nvim tree-sitter &&
  ! confirm_install "Install missing editor tooling?"; then
  install_editor=false
fi

install_ai=true
if commands_missing codex claude mcp-hub codegraph &&
  ! confirm_install "Install missing AI tools?"; then
  install_ai=false
fi

install_utilities=true
if commands_missing fzf fd tree rg gh sqlite3 xclip &&
  ! confirm_install "Install missing command-line utilities?"; then
  install_utilities=false
fi

install_operations=true
if commands_missing kubectl nc &&
  ! confirm_install "Install missing operations tools?"; then
  install_operations=false
fi

install_terminal=true
if commands_missing tmux kitty &&
  ! confirm_install "Install missing terminal applications?"; then
  install_terminal=false
fi

install_input=true
if [ "$is_wsl" = "true" ] &&
  commands_missing fcitx5 &&
  ! confirm_install "Install missing input method support?"; then
  install_input=false
fi

# Discover all package files and sort by filename
# Package files should use numeric prefixes (e.g., 00-kubectl.sh, 10-m4.sh)
# to control installation order
shopt -s nullglob
packages=("$SCRIPT_DIR/packages/posix/"*.sh)
shopt -u nullglob

if [ ${#packages[@]} -eq 0 ]; then
  echo "No packages found in $SCRIPT_DIR/packages/posix/"
else
  # Sort packages by filename (compatible with bash 3.2+)
  sorted_packages=()
  while IFS= read -r -d '' file; do
    sorted_packages+=("$file")
  done < <(printf '%s\0' "${packages[@]}" | sort -z)

  echo "==> Found ${#sorted_packages[@]} packages"

  # Install in filename order
  for pkg_file in "${sorted_packages[@]}"; do
    pkg_basename=$(basename "$pkg_file" .sh)
    pkg_category=""
    case "$pkg_basename" in
    01-zsh | 02-build-essential | 05-unzip | 10-m4 | 11-autoconf | 12-automake | 13-pkg-config | 20-openssl | 21-libevent | 30-ncurses | 31-utf8proc | 40-gettext | 41-libgpg-error | 42-libgcrypt | 43-libassuan | 44-libksba | 45-libnpth | 46-texinfo | 47-pinentry | 48-gpg)
      pkg_category=base
      ;;
    03-uv | 04-mise | 56-nvm | 62-luajit | 70-rust)
      pkg_category=runtimes
      ;;
    50-nvim | 72-tree-sitter)
      pkg_category=editor
      ;;
    57-codex | 58-claude | 59-mcp-hub | 59-codegraph)
      pkg_category=ai
      ;;
    60-fzf | 63-fd | 64-tree | 66-ripgrep | 67-xclip | 73-gh | 74-sqlite3)
      pkg_category=utilities
      ;;
    65-kubectl | 68-netcat)
      pkg_category=operations
      ;;
    32-tmux | 71-kitty)
      pkg_category=terminal
      ;;
    07-fcitx5)
      pkg_category=input
      ;;
    esac

    case "$pkg_category" in
    base | runtimes | editor | ai | utilities | operations | terminal | input)
      if ! category_enabled "$pkg_category"; then
        echo "==> Skipping $pkg_basename"
        continue
      fi
      ;;
    esac

    echo "==> Processing: $pkg_basename"

    # Source the package file (which will execute the install function)
    source "$pkg_file"
  done
fi

echo ""
echo "==> Generating shell completions"

shopt -s nullglob
completion_scripts=("$SCRIPT_DIR/completions/posix/"*.sh)
shopt -u nullglob

if [ ${#completion_scripts[@]} -eq 0 ]; then
  echo "No completion generators found in $SCRIPT_DIR/completions/"
else
  sorted_completion_scripts=()
  while IFS= read -r -d '' file; do
    sorted_completion_scripts+=("$file")
  done < <(printf '%s\0' "${completion_scripts[@]}" | sort -z)

  echo "==> Found ${#sorted_completion_scripts[@]} completion generators"

  # Completion generation is optional. A failed generator must not fail the
  # whole installation, so run each one in an isolated, non-errexit shell.
  for completion_script in "${sorted_completion_scripts[@]}"; do
    completion_basename=$(basename "$completion_script" .sh)
    echo "==> Processing completion: $completion_basename"

    if ! (
      set +e
      source "$completion_script"
    ); then
      echo "Warning: Completion generator failed: $completion_basename" >&2
    fi
  done
fi

echo ""
echo "==> Installation complete!"
