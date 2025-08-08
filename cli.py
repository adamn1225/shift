#!/usr/bin/env python3
"""
CLI entry points for PDF document tools.
"""

import sys
from pathlib import Path
# Add the current directory to the path so we can import our modules
sys.path.insert(0, str(Path(__file__).parent))

from shift_converter import main as shift_converter_main

def main():
    """Main entry point - just call the shift_converter_main directly."""
    shift_converter_main()

def shift_converter_cli():
    """Entry point for doc-convert command."""
    sys.argv[0] = 'shift'
    shift_converter_main()

def pdf_compress_cli():
    """Entry point for pdf-compress command."""
    try:
        from pdf_compressor import main as pdf_compress_main
        sys.argv[0] = 'shift-compress'
        pdf_compress_main()
    except ImportError:
        print("PDF compression module not available")

def pdf_pages_cli():
    """Entry point for pdf-pages command."""
    try:
        from pdf_page_manager import main as pdf_pages_main
        sys.argv[0] = 'shift-pages'
        pdf_pages_main()
    except ImportError:
        print("PDF page manager module not available")

def pdf_editor_cli():
    """Entry point for pdf-editor command."""
    try:
        from pdf_editor import main as pdf_editor_main
        sys.argv[0] = 'shift-edit'
        pdf_editor_main()
    except ImportError:
        print("PDF editor module not available")


def pdf_ocr_cli():
    """Entry point for pdf-ocr command."""
    try:
        from pdf_ocr import main as pdf_ocr_main
        sys.argv[0] = 'shift-ocr'
        pdf_ocr_main()
    except ImportError:
        print("PDF OCR module not available")

if __name__ == "__main__":
    main()
