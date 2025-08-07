#!/bin/bash
# Cross-platform installation script for Shift Cloud CLI
# Works on Linux, macOS, and WSL

set -e

echo ""
echo "=========================================="
echo "   Shift Cloud CLI - Unix Installer"
echo "=========================================="
echo ""

# Detect OS
OS="unknown"
ARCH="unknown"

case "$(uname -s)" in
    Linux*)     OS="linux";;
    Darwin*)    OS="macos";;
    CYGWIN*)    OS="windows";;
    MINGW*)     OS="windows";;
    *)          OS="unknown";;
esac

case "$(uname -m)" in
    x86_64*)    ARCH="x64";;
    amd64*)     ARCH="x64";;
    arm64*)     ARCH="arm64";;
    aarch64*)   ARCH="arm64";;
    *)          ARCH="x64";;  # Default to x64
esac

echo "Detected OS: $OS"
echo "Detected Architecture: $ARCH"
echo ""

# Set download URL based on OS
BASE_URL="https://github.com/yourusername/shift/releases/latest/download"
case "$OS" in
    "linux")
        DOWNLOAD_URL="$BASE_URL/shift-cloud-linux-$ARCH"
        INSTALL_DIR="$HOME/.local/bin"
        BINARY_NAME="shift-cloud"
        ;;
    "macos")
        DOWNLOAD_URL="$BASE_URL/shift-cloud-macos-$ARCH"
        INSTALL_DIR="$HOME/.local/bin"
        BINARY_NAME="shift-cloud"
        ;;
    *)
        echo "❌ Unsupported OS: $OS"
        echo "Please install manually or use Python:"
        echo "  pip install shift-cloud-cli"
        exit 1
        ;;
esac

# Create install directory
mkdir -p "$INSTALL_DIR"

echo "📥 Downloading from: $DOWNLOAD_URL"
echo "📁 Installing to: $INSTALL_DIR/$BINARY_NAME"
echo ""

# Download binary
if command -v curl >/dev/null 2>&1; then
    curl -L -o "$INSTALL_DIR/$BINARY_NAME" "$DOWNLOAD_URL"
elif command -v wget >/dev/null 2>&1; then
    wget -O "$INSTALL_DIR/$BINARY_NAME" "$DOWNLOAD_URL"
else
    echo "❌ Neither curl nor wget found!"
    echo "Please install curl or wget, or install via Python:"
    echo "  pip install shift-cloud-cli"
    exit 1
fi

# Make executable
chmod +x "$INSTALL_DIR/$BINARY_NAME"

# Check if install directory is in PATH
if [[ ":$PATH:" == *":$INSTALL_DIR:"* ]]; then
    echo "✅ $INSTALL_DIR is already in PATH"
else
    echo "⚠️  Adding $INSTALL_DIR to PATH"
    
    # Add to appropriate shell config
    if [[ "$SHELL" == *"zsh"* ]]; then
        echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
        echo "Added to ~/.zshrc"
    elif [[ "$SHELL" == *"bash"* ]]; then
        echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
        echo "Added to ~/.bashrc"
    else
        echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.profile
        echo "Added to ~/.profile"
    fi
    
    echo "Please restart your terminal or run:"
    echo "  export PATH=\"$HOME/.local/bin:\$PATH\""
fi

echo ""
echo "=========================================="
echo "   Installation Complete! ✅"
echo "=========================================="
echo ""
echo "Usage:"
echo "  shift-cloud document.docx --to pdf"
echo "  shift-cloud report.md --to html"
echo ""
echo "Test installation:"
echo "  shift-cloud --help"
echo ""
