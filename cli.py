#!/usr/bin/env python3
"""
CLI entry points for PDF document tools.
"""

import sys
from pathlib import Path

# Add the current directory to the path so we can import our modules
sys.path.insert(0, str(Path(__file__).parent))

from doc_converter import main as doc_converter_main
# Import other modules as needed

def doc_convert_cli():
    """Entry point for doc-convert command."""
    sys.argv[0] = 'doc-convert'
    doc_converter_main()

def pdf_compress_cli():
    """Entry point for pdf-compress command."""
    print("PDF compress functionality - coming soon!")
    # Import and call pdf_outlook_attachable main function

def pdf_pages_cli():
    """Entry point for pdf-pages command."""
    print("PDF pages functionality - coming soon!")
    # Import and call pdf_page_manager main function

def pdf_editor_cli():
    """Entry point for pdf-editor command."""
    print("PDF editor functionality - coming soon!")
    # Import and call pdf_editor main function

if __name__ == "__main__":
    doc_convert_cli()
