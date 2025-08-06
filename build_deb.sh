#!/bin/bash
"""
Build Debian package for Shift
"""

set -e

echo "🏗️  Building Debian package for Shift..."

# Make sure we're in the right directory
cd "$(dirname "$0")"

# Install build dependencies
echo "📦 Installing build dependencies..."
sudo apt-get update
sudo apt-get install -y debhelper-compat dh-python python3-setuptools python3-all build-essential

# Make sure debian files are executable
chmod +x debian/rules
chmod +x debian/scripts/shift

# Clean previous builds
echo "🧹 Cleaning previous builds..."
rm -rf debian/shift/
rm -f ../*.deb ../*.changes ../*.buildinfo

# Build the package
echo "🔨 Building package..."
dpkg-buildpackage -us -uc -b

echo ""
echo "✅ Package built successfully!"
echo ""
echo "📦 Package file:"
ls -la ../*.deb

echo ""
echo "🚀 To install:"
echo "   sudo dpkg -i ../shift_*.deb"
echo "   sudo apt-get install -f  # Fix any dependency issues"
echo ""
echo "📝 Then use:"
echo "   shift document.docx --to pdf"
echo "   shift report.md --to html --css professional.css"
echo ""
echo "🗑️  To uninstall:"
echo "   sudo apt-get remove shift"
