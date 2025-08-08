#!/bin/bash

echo "🛠️  Building Windows executable for Shift..."

# Ensure pyinstaller is available
pip install --upgrade pyinstaller

# Clean old builds
rm -rf build dist shift.spec

# Create the standalone binary
pyinstaller --onefile --name shift --add-data "*.css;." doc_converter.py

if [ ! -f "dist/shift.exe" ]; then
  echo "❌ Build failed: shift.exe not found"
  exit 1
fi

echo "✅ Built shift.exe in dist/"

# Prepare Chocolatey package folder
mkdir -p chocolatey/tools
cp dist/shift.exe chocolatey/tools/

echo "📦 Copied shift.exe to chocolatey/tools/"

# Package .nupkg
cd chocolatey
choco pack shift.nuspec

echo "✅ .nupkg package built:"
ls *.nupkg

echo ""
echo "🚀 To publish:"
echo "  choco push shift-cli.1.0.1.nupkg --source https://push.chocolatey.org/ --api-key <your-api-key>"
