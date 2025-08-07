#!/usr/bin/env python3
"""
CLI entry points for PDF document tools.
"""

import sys
from pathlib import Path

# Add the current directory to the path so we can import our modules
sys.path.insert(0, str(Path(__file__).parent))

from doc_converter import main as doc_converter_main

def doc_convert_cli():
    """Entry point for doc-convert command."""
    sys.argv[0] = 'shift'
    doc_converter_main()

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

def pdf_forms_cli():
    """Entry point for pdf-forms command."""
    try:
        from pdf_form_filler import main as pdf_forms_main
        sys.argv[0] = 'shift-forms'
        pdf_forms_main()
    except ImportError:
        print("PDF forms module not available")

def pdf_ocr_cli():
    """Entry point for pdf-ocr command."""
    try:
        from pdf_ocr import main as pdf_ocr_main
        sys.argv[0] = 'shift-ocr'
        pdf_ocr_main()
    except ImportError:
        print("PDF OCR module not available")

def image_compress_cli():
    """Entry point for image-compress command."""
    try:
        from image_compressor import main as image_compress_main
        sys.argv[0] = 'shift-images'
        image_compress_main()
    except ImportError:
        print("Image compressor module not available")

if __name__ == "__main__":
    doc_convert_cli()
