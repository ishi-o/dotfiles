#!/usr/bin/env bash

pkg_name="pnpm"
node_version="${NODE_VERSION:-22}"

install_pnpm() {
  if [ "$os" = "windows" ]; then
    return 0
  fi

  export PATH="$PNPM_HOME/bin:$PNPM_HOME:$PATH"
  hash -r

  if ! check_installed pnpm; then
    echo "Installing pnpm..."
    curl_download https://get.pnpm.io/install.sh | sh -s -- || return 1
    hash -r
  fi

  if ! check_installed pnpm; then
    echo "Error: pnpm was not installed" >&2
    return 1
  fi

  local managed_node="$PNPM_HOME/bin/node"
  if [ -x "$managed_node" ] && "$managed_node" -v 2>/dev/null | grep -q "^v${node_version}"; then
    return 0
  fi

  echo "Setting node ${node_version} as the pnpm runtime..."
  pnpm runtime set node "$node_version" -g

  if ! check_installed npm; then
    echo "Installing npm via pnpm..."
    pnpm add -g npm || return 1
  fi
}

install_pnpm
