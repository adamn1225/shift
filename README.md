# PDF Outlook Attachable

A comprehensive toolkit for PDF compression, page management, OCR text extraction, and document conversion.

## Quick Start (Global Installation)

1. **Clone and setup:**
   ```bash
   cd ~/pdf_scripts
   source .venv/bin/activate
   ./setup_global.sh
   ```

2. **Use anywhere:**
   ```bash
   pdf-compress large_file.pdf
   doc-convert document.docx --to pdf
   pdf-pages document.pdf --analyze
   ```

## Tools Overview

- **`pdf-compress`** - Compress PDFs for email attachments (was `pdf_outlook_attachable.py`)
- **`pdf-pages`** - Remove pages interactively to reduce file size (was `pdf_page_manager.py`)
- **`doc-convert`** - Convert between document formats (was `doc_converter.py`)
- **`pdf-editor`** - Advanced PDF editing with GUI (was `pdf_editor.py`)

## Features

- **Work from anywhere:** Global commands available in any directory
- **Auto-detection:** Formats detected from file extensions
- **Batch processing:** Handle entire folders with a single command
- **Quality options:** Multiple compression and conversion levels
- **External tool integration:** Uses Pandoc, LibreOffice, and wkhtmltopdf when available
- **Comprehensive help:** Each tool provides detailed `--help` documentation

---

## PDF Compression for Outlook

### Basic Compression
```bash
pdf-compress document.pdf                    # Compress to under 10MB
pdf-compress --dual large_file.pdf          # Create both quality & outlook versions
pdf-compress --batch folder/                # Process whole folders
```

### Two-Step Approach for Large Files

For very large PDFs (>30MB), use a two-step approach:

1. **First, remove heavy pages:**
```bash
pdf-pages large_file.pdf --analyze          # See page breakdown
pdf-pages large_file.pdf                    # Interactive page removal
```

2. **Then compress the result:**
```bash
pdf-compress edited_file.pdf --dual         # Compress the page-reduced version
```

**Example Results:**
- Original: 47MB → Page-reduced: 32MB → Final: 13MB ✓

---

## PDF Page Management

Analyze PDF structure and remove pages to reduce file size:

```bash
pdf-pages document.pdf --analyze            # Show page breakdown
pdf-pages document.pdf                      # Interactive page removal
pdf-pages document.pdf --remove 1,3,5-7     # Remove specific pages
```

The analyzer shows which pages have the most images and estimated size impact.

---

## Document Conversion

Convert a Word document to PDF:
```bash
doc-convert document.docx --to pdf
```

Convert a Markdown file to HTML with a custom stylesheet:
```bash
doc-convert report.md --to html --css style.css
```

Extract text from a PDF file:
```bash
doc-convert file.pdf --to text --output extracted.txt
```

Batch convert all Word documents in a folder to PDF:
```bash
doc-convert folder/ --batch --from docx --to pdf --output converted/
```

---

## Summary

You now have a complete PDF management toolkit:

1. **For regular PDFs**: Use `pdf-compress --dual` to create both quality and email versions
2. **For large PDFs**: Use `pdf-pages` first to remove heavy pages, then compress
3. **For document conversion**: Use `doc-convert` between formats

All tools work from anywhere in your terminal and provide detailed help with `-h` or `--help`.
