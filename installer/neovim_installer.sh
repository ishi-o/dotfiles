#!/bin/bash
set -euo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
log_warn() { echo -e "${YELLOW}[WARNING]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

handle_error() {
    log_error "Build failed, cleaning up..."
    if [ -d "$BUILD_DIR" ]; then
        rm -rf "$BUILD_DIR"
    fi
	chezmoi state reset --force
}
trap handle_error ERR

HOME="$HOME"
LOCAL_DIR="$HOME/.local"
BIN_DIR="$HOME/.local/bin"
SHARE_DIR="$HOME/.local/share"
OPT_DIR="$HOME/opt"

NEOVIM_DIR="$OPT_DIR/nvim"
BUILD_DIR="/tmp/neovim-build-$$"

MAX_RETRIES=3

if command -v nvim &> /dev/null && nvim --version &> /dev/null; then
    log_success "Detected neovim: $(nvim --version | head -n1)"
    exit 0
fi

log_info "Installing Neovim from source..."

mkdir -p "$OPT_DIR" "$BIN_DIR" "$BUILD_DIR"

log_info "Fetching latest stable version..."
get_latest_version() {
    curl -s https://api.github.com/repos/neovim/neovim/releases/latest | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/'
}

RETRY_COUNT=0
VERSION=""
while [ $RETRY_COUNT -lt $MAX_RETRIES ] && [ -z "$VERSION" ]; do
    VERSION=$(get_latest_version)
    if [ -z "$VERSION" ]; then
        RETRY_COUNT=$((RETRY_COUNT + 1))
        log_warn "Failed to fetch version, retrying... ($RETRY_COUNT/$MAX_RETRIES)"
        sleep 2
    fi
done

if [ -z "$VERSION" ]; then
    log_error "Failed to fetch Neovim version after $MAX_RETRIES attempts"
    exit 1
fi

log_info "Latest stable version: $VERSION"

cd "$BUILD_DIR"

DOWNLOAD_URL="https://github.com/neovim/neovim/archive/refs/tags/${VERSION}.tar.gz"

RETRY_COUNT=0
while [ $RETRY_COUNT -lt $MAX_RETRIES ]; do
    log_info "Downloading Neovim ${VERSION}..."
    if curl -L -f "$DOWNLOAD_URL" | tar xz --strip-components=1; then
        log_success "Download completed"
        break
    else
        RETRY_COUNT=$((RETRY_COUNT + 1))
        log_warn "Download failed, retrying... ($RETRY_COUNT/$MAX_RETRIES)"
        sleep 1
    fi
done

if [ $RETRY_COUNT -eq $MAX_RETRIES ]; then
    log_error "Failed to download Neovim after $MAX_RETRIES attempts"
    exit 1
fi

log_info "Building Neovim (this may take a while)..."
make CMAKE_BUILD_TYPE=Release \
     CMAKE_INSTALL_PREFIX="$NEOVIM_DIR" \
     CMAKE_EXTRA_FLAGS="-DSTATIC_BUILD=1"

log_info "Installing Neovim..."
make install

ln -sf "$NEOVIM_DIR/bin/nvim" "$BIN_DIR/nvim"

rm -rf "$BUILD_DIR"

if command -v nvim &> /dev/null; then
    log_success "Neovim installed successfully: $(nvim --version | head -n1)"
    log_info "Installation directory: $NEOVIM_DIR"
    log_info "Binary location: $BIN_DIR/nvim"
else
    log_warn "Neovim binary not found in PATH, but installed to $NEOVIM_DIR"
    log_info "Please ensure $BIN_DIR is in your PATH"
fi
