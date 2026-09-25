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
source "$SCRIPT_DIR/lib/env.sh"
source "$SCRIPT_DIR/lib/helpers.sh"

step_enabled() {
  local value="${1:-true}"
  case "$(printf '%s' "$value" | tr '[:upper:]' '[:lower:]')" in
  false|0|no|off) return 1 ;;
  esac
  return 0
}

# Handle skip flag
if [ "${SKIP_INSTALL:-false}" != "false" ]; then
  echo "Skipping install..."
  exit 0
fi

echo "==> Starting package installation"

# Discover all package files and sort by filename
# Package files should use numeric prefixes (e.g., 00-kubectl.sh, 10-m4.sh)
# to control installation order
shopt -s nullglob
packages=("$SCRIPT_DIR/packages/"*.sh)
shopt -u nullglob

if [ "$os" = "windows" ]; then
  windows_packages=(
    03-uv
    04-mise
    50-nvim
    56-nvm
    57-codex
    58-claude
    59-mcp-hub
    60-fzf
    63-fd
    65-kubectl
    66-ripgrep
    70-rust
    73-gh
  )
fi

if [ ${#packages[@]} -eq 0 ]; then
  echo "No packages found in $SCRIPT_DIR/packages/"
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
    if [ "$os" = "windows" ]; then
      case " ${windows_packages[*]} " in
      *" $pkg_basename "*)
        ;;
      *)
        echo "==> Skipping $pkg_basename on Windows"
        continue
        ;;
      esac
    fi

    case "$pkg_basename" in
    06-cjk-fonts)
      step_enabled "${INSTALL_FONTS:-true}" || {
        echo "==> Skipping $pkg_basename (INSTALL_FONTS=false)"
        continue
      }
      ;;
    60-fzf|63-fd|64-tree|65-kubectl|66-ripgrep|67-xclip|70-rust|71-kitty|72-tree-sitter|73-gh)
      step_enabled "${INSTALL_DEV_TOOLS:-true}" || {
        echo "==> Skipping $pkg_basename (INSTALL_DEV_TOOLS=false)"
        continue
      }
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
completion_scripts=("$SCRIPT_DIR/completions/"*.sh)
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
