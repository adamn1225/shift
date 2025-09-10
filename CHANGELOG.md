# Changelog

All notable changes to Shift CLI will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.3] - 2025-09-10

### Fixed
- GitHub Actions workflow for automated releases
- PyPI publication with trusted publishing
- Linux-focused distribution strategy
- Workflow permissions for OIDC token publishing

### Technical
- Removed Windows build dependencies to focus on Linux/Python distribution
- Added required `id-token: write` permissions for PyPI publishing
- Simplified release workflow for better reliability
- Updated release notes with improved v1.0.2 features

## [1.0.2] - 2025-09-10

### Added
- Intelligent paragraph detection in text-to-HTML conversion
- Beautiful modern CSS styling for HTML output
- Company entry detection with special formatting
- Responsive design with centered layout and professional typography
- Proper `<p>` paragraph tags instead of basic `<br>` line breaks

### Improved
- Text-to-HTML conversion now produces professional, structured output
- HTML styling includes modern fonts, colors, and spacing
- Company listings are automatically formatted with highlighted names and contact info
- Overall readability and presentation of converted documents

### Technical
- Enhanced `_format_text_content()` method for smart text parsing
- Added company header detection with location parsing
- Improved CSS with professional color scheme and typography
- Better document structure with semantic HTML elements

## [1.0.1] - 2025-09-09

### Added
- Initial release with document conversion capabilities
- PDF compression and OCR functionality
- Batch processing support
- Cross-platform CLI tools

### Features
- Convert between PDF, Word, HTML, Markdown, Text formats
- Compress PDFs for email attachments
- Extract text from scanned documents
- Command-line tools: shift-convert, shift-compress, shift-ocr, etc.

## [1.0.0] - 2025-09-08

### Added
- Initial project setup
- Core document conversion framework
- Basic CLI interface
