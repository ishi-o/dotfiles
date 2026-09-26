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
  n|N|no|No|NO) return 1 ;;
  *) return 0 ;;
  esac
}

fonts_missing() {
  if ! command -v fc-list >/dev/null 2>&1; then
    return 0
  fi
  ! fc-list :lang=zh 2>/dev/null | grep -q .
}

dev_tools_missing() {
  local command
  for command in fzf fd tree kubectl rg gh kitty rustup tree-sitter xclip; do
    command -v "$command" >/dev/null 2>&1 || return 0
  done
  return 1
}

echo "==> Starting package installation"

install_fonts=true
if fonts_missing && ! confirm_install "Install missing CJK fonts?"; then
  install_fonts=false
fi

install_dev_tools=true
if dev_tools_missing && ! confirm_install "Install missing developer tools?"; then
  install_dev_tools=false
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
    case "$pkg_basename" in
    06-cjk-fonts)
      if [ "$install_fonts" != "true" ]; then
        echo "==> Skipping $pkg_basename"
        continue
      fi
      ;;
    60-fzf|63-fd|64-tree|65-kubectl|66-ripgrep|67-xclip|70-rust|71-kitty|72-tree-sitter|73-gh)
      if [ "$install_dev_tools" != "true" ]; then
        echo "==> Skipping $pkg_basename"
        continue
      fi
      ;;
    esac

    echo "==> Processing: $pkg_basename"

    # Source the package file (which will execute the install function)
    # shellcheck disable=SC1090
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

    if ! (set +e; source "$completion_script"); then
      echo "Warning: Completion generator failed: $completion_basename" >&2
    fi
  done
fi

echo ""
echo "==> Installation complete!"
