#!/usr/bin/env bash

pkg_name="github-mcp-server"

install_github_mcp_server() {
  if check_installed github-mcp-server; then
    return 0
  fi

  local release_goos release_goarch
  case "$os" in
  darwin) release_goos="Darwin" ;;
  *) release_goos="Linux" ;;
  esac
  case "$arch" in
  amd64) release_goarch="x86_64" ;;
  arm64) release_goarch="arm64" ;;
  *)
    echo "Skipping github-mcp-server: unsupported arch ${arch}" >&2
    return 0
    ;;
  esac

  download_binary \
    "github-mcp-server" \
    "latest" \
    "https://github.com/github/github-mcp-server/releases/latest/download/github-mcp-server_${release_goos}_${release_goarch}.tar.gz" \
    "github-mcp-server" \
    "$HOME/.local/bin/github-mcp-server"
}

install_github_mcp_server
