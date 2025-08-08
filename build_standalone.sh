#!/bin/bash
# Build standalone executables for multiple platforms

echo "🚀 Building Shift CLI standalone executables..."
echo ""

# Check if PyInstaller is installed
if ! command -v pyinstaller &> /dev/null; then
    echo "📦 Installing PyInstaller..."
    pip install pyinstaller
fi

# Clean previous builds
echo "🧹 Cleaning previous builds..."
rm -rf build/ dist/

# Build Windows executable
echo "🪟 Building Windows executable..."
pyinstaller --clean shift.spec

# Check if build was successful
if [ -f "dist/shift.exe" ] || [ -f "dist/shift" ]; then
    echo "✅ Build successful!"
    echo ""
    echo "📁 Files created:"
    ls -la dist/
    echo ""
    echo "📊 File sizes:"
    du -h dist/*
    echo ""
    echo "🎯 Ready for distribution!"
    echo "   Windows: dist/shift.exe"
    echo "   Linux/Mac: dist/shift"
else
    echo "❌ Build failed!"
    exit 1
fi

# Optional: Create archives for distribution
echo ""
echo "📦 Creating distribution archives..."

# Create Windows archive
if [ -f "dist/shift.exe" ]; then
    zip -j dist/shift-windows.zip dist/shift.exe
    echo "✅ Created: dist/shift-windows.zip"
fi

# Create Linux archive (if built on Linux)
if [ -f "dist/shift" ] && [ "$(uname)" = "Linux" ]; then
    tar -czf dist/shift-linux.tar.gz -C dist shift
    echo "✅ Created: dist/shift-linux.tar.gz"
fi

echo ""
echo "🎉 Standalone executable build complete!"
echo ""
echo "📋 Next steps:"
echo "1. Test the executable: ./dist/shift --help"
echo "2. Upload to GitHub releases"
echo "3. Update Chocolatey package with new executable"
echo "4. Update download links in install scripts"
