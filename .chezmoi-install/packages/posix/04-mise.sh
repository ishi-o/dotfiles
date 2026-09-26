#!/usr/bin/env bash

pkg_name="mise"
pkg_version="${MISE_VERSION:-latest}"

install_mise() {
  if [ -x "$MISE_INSTALL_PATH" ]; then
    echo "mise is already installed at $MISE_INSTALL_PATH"
    return 0
  fi

  echo "Installing mise ${pkg_version}..."
  mkdir -p "$(dirname "$MISE_INSTALL_PATH")" || return 1

  if [ "$os" = "windows" ]; then
    local temp_dir="/tmp/mise.$$"
    local version_path="latest"
    [ "$pkg_version" != "latest" ] && version_path="v${pkg_version#v}"
    mkdir -p "$temp_dir" || return 1
    download_extract \
      "https://github.com/jdx/mise/releases/${version_path}/download/mise-windows-x64.zip" \
      "$temp_dir" || {
      rm -rf "$temp_dir"
      return 1
    }
    cp "$temp_dir/mise/bin/mise.exe" "$MISE_INSTALL_PATH" || {
      rm -rf "$temp_dir"
      return 1
    }
    rm -rf "$temp_dir"
  else
    # Use the standalone installer so mise does not modify shell files managed
    # by chezmoi. MISE_INSTALL_PATH keeps the binary under USR_HOME.
    curl -fsSL https://mise.jdx.dev/install.sh |
      MISE_INSTALL_PATH="$MISE_INSTALL_PATH" MISE_INSTALL_SKIP_IF_EXISTS=1 sh || return 1
  fi

  if [ ! -x "$MISE_INSTALL_PATH" ]; then
    echo "Error: mise was not installed at $MISE_INSTALL_PATH" >&2
    return 1
  fi
}

install_mise
