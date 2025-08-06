# Build script for Windows executable
# Run this in PowerShell or Git Bash

echo "🏗️  Building Windows executable for Shift..."

# Install PyInstaller if not already installed
pip install pyinstaller

# Clean previous builds
if [ -d "dist" ]; then rm -rf dist; fi
if [ -d "build" ]; then rm -rf build; fi

# Create executable
pyinstaller --onefile --name shift --add-data "*.css;." doc_converter.py

echo "✅ Built shift.exe in dist/ folder"
echo "📦 You can now distribute dist/shift.exe"
echo ""
echo "🚀 Users can:"
echo "  1. Download shift.exe"
echo "  2. Add to PATH or put in C:\\Windows\\System32"
echo "  3. Use: shift document.docx --to pdf"
