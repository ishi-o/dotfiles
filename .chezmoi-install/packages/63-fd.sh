#!/usr/bin/env bash

pkg_name="fd"
pkg_version="${FD_VERSION:-10.1.0}"

install_fd() {
  if check_installed fd; then
    return 0
  fi

  # Try package manager first (apt calls it fd-find)
  if try_package_manager fd-find; then
    # Create symlink from fd-find to fd if needed
    if check_installed fdfind && ! check_installed fd; then
      ln -sf "$(command -v fdfind)" "$HOME/.local/bin/fd"
    fi
    return 0
  fi

  # Fall back to downloading pre-built binary
  echo "Installing fd ${pkg_version}..."

  local darwin_target="apple-darwin"
  local linux_target="unknown-linux-gnu"
  local windows_target="x86_64-pc-windows-msvc"
  local target

  if [[ "$os" == "darwin" ]]; then
    target="$darwin_target"
  elif [[ "$os" == "windows" ]]; then
    target="$windows_target"
  else
    target="$linux_target"
  fi

  local archive_name="fd-v${pkg_version}-${arch}-${target}"
  local archive_extension="tar.gz"
  [ "$os" = "windows" ] && archive_extension="zip"
  local url="https://github.com/sharkdp/fd/releases/download/v${pkg_version}/${archive_name}.${archive_extension}"

  if [ "$os" = "windows" ]; then
    download_binary "$pkg_name" "$pkg_version" "$url" "fd.exe" "$HOME/.local/bin/fd.exe"
  else
    curl -sL "$url" | tar -zxf - --strip-components=1 -C "$HOME/.local/bin" "${archive_name}/fd" || return 1
    chmod +x "$HOME/.local/bin/fd" || return 1
  fi
}

install_fd
