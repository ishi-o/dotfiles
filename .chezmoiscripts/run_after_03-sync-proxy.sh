#!/usr/bin/env bash

set -euo pipefail

config="${XDG_CONFIG_HOME:-$HOME/.config}/proxy/config"
[ -f "$config" ] || exit 0

set_proxy="$HOME/.local/bin/set-proxy"
[ -x "$set_proxy" ] || {
  echo "Warning: set-proxy is not installed; skipping proxy synchronization." >&2
  exit 0
}

"$set_proxy" --sync
