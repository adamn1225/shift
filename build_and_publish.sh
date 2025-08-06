#!/bin/bash
"""
Build and publish script for PyPI
"""

echo "🏗️  Building package..."

# Clean previous builds
rm -rf dist/ build/ *.egg-info/

# Build package
python -m build

echo "📦 Package built successfully!"
echo "Contents of dist/:"
ls -la dist/

echo ""
echo "🚀 To publish to PyPI:"
echo "1. Test upload: python -m twine upload --repository testpypi dist/*"
echo "2. Real upload: python -m twine upload dist/*"
echo ""
echo "📝 Users will then install with:"
echo "   pip install pdf-document-tools"
echo ""
echo "🔧 And use commands like:"
echo "   doc-convert report.md --to html --css style.css"
echo "   pdf-compress large-file.pdf"
