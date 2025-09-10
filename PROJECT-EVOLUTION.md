# Shift CLI Project Evolution & Development Guide

## 📋 Table of Contents
- [Project Overview](#project-overview)
- [Major Milestones Achieved](#major-milestones-achieved)
- [Enhanced Text-to-HTML Conversion](#enhanced-text-to-html-conversion)
- [Technical Architecture](#technical-architecture)
- [Development Workflow](#development-workflow)
- [Publishing & Distribution](#publishing--distribution)
- [Version History](#version-history)
- [Future Development Guide](#future-development-guide)
- [Troubleshooting](#troubleshooting)

## 🎯 Project Overview

**Shift CLI** is a universal document converter that transforms files between various formats (PDF, Word, HTML, Markdown, Text). The project evolved from a basic conversion tool to a sophisticated document processor with professional HTML output capabilities.

### Core Features
- Document format conversion (PDF ↔ Word ↔ HTML ↔ Markdown ↔ Text)
- PDF compression and optimization
- OCR text extraction from scanned documents
- Advanced PDF editing capabilities
- Professional HTML generation with enhanced styling

## 🚀 Major Milestones Achieved

### 1. Initial Challenge: Bash Conflict Resolution
**Problem**: The CLI tool name "shift" conflicted with the bash builtin `shift` command on Linux systems.

**Solution**: 
- Created `shift-convert` as the primary command
- Maintained `shift` for backward compatibility
- Implemented proper entry points in `setup.py`

### 2. Enhanced Text-to-HTML Conversion (Major Breakthrough)
**Problem**: Basic text conversion produced poor quality HTML with only `<br>` tags.

**Solution**: Complete rewrite of the `text_to_html` method with:
- Intelligent paragraph detection
- Company entry recognition and formatting
- Professional CSS styling
- Semantic HTML structure

### 3. PyPI Publishing & Distribution
**Problem**: Package name conflicts and publishing failures.

**Solution**:
- Resolved package naming conflict (`shift` → `shift-cli`)
- Fixed GitHub Actions workflow for automated PyPI publishing
- Implemented proper API token authentication

### 4. Company Entry Grouping (v1.0.5)
**Enhancement**: Improved HTML structure to group related company information together instead of scattered individual divs.

## 🎨 Enhanced Text-to-HTML Conversion

### Before vs After Comparison

**Before (Basic):**
```html
<body>
    Company Example Corp<br>
    123 Main Street, Austin, TX 75201<br>
    Phone: (555) 123-4567<br>
</body>
```

**After (Enhanced v1.0.5):**
```html
<body>
    <div class="company-entry">
        <div class="company-name">Company Example Corp</div>
        <div class="contact-info">123 Main Street, Austin, TX 75201</div>
        <div class="contact-info">Phone: (555) 123-4567</div>
    </div>
</body>
```

### Key Technical Components

1. **`_format_text_content()`**: Main content processing engine
2. **`_format_company_entry()`**: Groups company information into structured HTML
3. **`_looks_like_company_header()`**: Intelligent company name detection
4. **`_looks_like_contact_info()`**: Contact information pattern recognition

### CSS Styling Features
- Modern typography (Segoe UI font stack)
- Responsive design (max-width: 800px, centered)
- Professional color scheme (#2c3e50 for headings, #333 for text)
- Card-style company entries with subtle shadows
- Optimized spacing and readability

## 🏗️ Technical Architecture

### File Structure
```
shift/
├── shift_converter.py      # Core conversion engine
├── pdf_compressor.py       # PDF compression utilities
├── pdf_editor.py          # PDF editing capabilities
├── pdf_ocr.py             # OCR text extraction
├── pdf_page_manager.py    # PDF page management
├── main.py                # Web interface entry point
├── setup.py               # Package configuration
├── requirements.txt       # Python dependencies
├── CHANGELOG.md           # Version history
└── .github/workflows/     # CI/CD automation
    └── release.yml        # Automated publishing
```

### Entry Points (CLI Commands)
- `shift-convert`: Main document conversion
- `shift-compress`: PDF compression
- `shift-pages`: PDF page management
- `shift-edit`: PDF editing
- `shift-ocr`: OCR extraction
- `shift-cloud`: Cloud integration
- `shift-web`: Web interface

### Dependencies
- **Core**: pypdf, fpdf2, python-docx, beautifulsoup4
- **Conversion**: markdown, docx2python, html2text
- **PDF Processing**: pdfkit, pymupdf, pytesseract
- **Image**: Pillow

## 🔄 Development Workflow

### 1. Local Development
```bash
# Clone repository
git clone https://github.com/adamn1225/shift.git
cd shift

# Create virtual environment
python3 -m venv .venv
source .venv/bin/activate

# Install dependencies
pip install -r requirements.txt

# Install in editable mode for development
pip install -e .

# Test changes
python3 shift_converter.py test_file.txt --to html --output test.html
```

### 2. Testing New Features
```bash
# Direct Python execution (bypasses CLI caching issues)
python3 shift_converter.py input.txt --to html --output result.html

# CLI testing (after pip install -e .)
shift-convert input.txt --to html --output result.html
```

### 3. Version Bump Process
1. Update version in `setup.py`
2. Update `CHANGELOG.md` with new features
3. Test thoroughly with sample files
4. Commit changes
5. Create and push tag

```bash
# Version bump example
git add .
git commit -m "v1.0.X - Description of changes"
git tag -a v1.0.X -m "Release v1.0.X - Brief description"
git push origin main && git push origin v1.0.X
```

## 📦 Publishing & Distribution

### Automated GitHub Actions Workflow
Location: `.github/workflows/release.yml`

**Triggers**: 
- Push to tags matching `v*` pattern
- Manual workflow dispatch

**Process**:
1. Build Python package (`python -m build`)
2. Upload to PyPI using API token
3. Create GitHub release with assets
4. Include installation scripts and documentation

### PyPI Configuration
- **Package Name**: `shift-cli` (to avoid conflicts)
- **Authentication**: PyPI API token stored in GitHub secrets as `PYPI_API_TOKEN`
- **Distribution**: Automatic on tag push

### Installation Methods
```bash
# Primary method (PyPI)
pip install shift-cli

# Linux/Unix script
curl -sSL https://raw.githubusercontent.com/adamn1225/shift/main/install-unix.sh | bash

# Development installation
git clone https://github.com/adamn1225/shift.git
cd shift
pip install -e .
```

## 📈 Version History

### v1.0.5 (Latest) - Enhanced Company Grouping
- Improved company entry grouping into single div containers
- Better semantic HTML structure
- Enhanced content recognition patterns

### v1.0.4 - Enhanced Text-to-HTML Conversion
- Complete rewrite of text-to-HTML conversion
- Professional CSS styling and typography
- Intelligent paragraph detection
- Company entry formatting

### v1.0.3 - PyPI Publishing Setup
- Fixed package naming conflicts
- Automated GitHub Actions workflow
- PyPI publishing configuration

### v1.0.2 - Core Functionality
- Basic document conversion capabilities
- PDF processing features
- Multi-format support

## 🔮 Future Development Guide

### Adding New Features

1. **New Conversion Method**:
   ```python
   def new_format_to_html(self, input_path: Path, output_path: Path, **kwargs) -> bool:
       """Convert new format to HTML."""
       try:
           # Implementation here
           return True
       except Exception as e:
           print(f"Error converting: {e}")
           return False
   ```

2. **Register in Converters Dictionary**:
   ```python
   self.converters = {
       # ... existing converters
       ('new_format', 'html'): self.new_format_to_html,
   }
   ```

3. **Update Format Aliases** (if needed):
   ```python
   self.format_aliases = {
       # ... existing aliases
       'new_ext': 'new_format',
   }
   ```

### Enhancing Text-to-HTML Conversion

**Key Areas for Improvement**:
- **Table Detection**: Recognize and format tabular data
- **List Processing**: Handle bulleted and numbered lists
- **Header Recognition**: Detect document titles and sections
- **Link Detection**: Convert URLs to clickable links
- **Image Handling**: Process embedded images or references

**Code Location**: `shift_converter.py` → `_format_text_content()` method

### CSS Styling Enhancements

**Current Themes**: Professional business theme
**Potential Additions**:
- Dark mode support
- Multiple theme options (academic, creative, minimal)
- Custom color schemes
- Print-optimized styles

### Performance Optimizations

**Current Bottlenecks**:
- Large file processing
- Complex document structures
- External tool dependencies

**Optimization Strategies**:
- Chunked file processing
- Async operations for batch conversions
- Caching mechanisms
- Progress indicators

## 🔧 Troubleshooting

### Common Issues & Solutions

#### 1. CLI Commands Not Working After Updates
**Symptom**: Old HTML output despite code changes
**Cause**: Package caching or outdated installation
**Solution**:
```bash
pip uninstall shift-cli -y
pip install -e .  # For development
# OR
pip install shift-cli --upgrade  # For latest PyPI version
```

#### 2. Package Name Conflicts
**Symptom**: "User not allowed to upload to project" errors
**Cause**: PyPI package name conflicts
**Solution**: Ensure package name in `setup.py` is unique (`shift-cli`)

#### 3. Local Testing Issues
**Symptom**: CLI shows different results than direct Python execution
**Cause**: Import path conflicts or virtual environment issues
**Solution**: Use direct execution for testing:
```bash
python3 shift_converter.py input.txt --to html --output test.html
```

#### 4. Missing Dependencies
**Symptom**: Import errors or conversion failures
**Cause**: Missing external tools or Python packages
**Solution**:
```bash
# Install Python dependencies
pip install -r requirements.txt

# Install external tools (Ubuntu/Debian)
sudo apt-get install wkhtmltopdf pandoc libreoffice tesseract-ocr
```

### Development Environment Setup Issues

#### Virtual Environment Problems
```bash
# Clean slate approach
rm -rf .venv
python3 -m venv .venv
source .venv/bin/activate
pip install --upgrade pip
pip install -r requirements.txt
```

#### Git Workflow Issues
```bash
# Reset to clean state
git stash  # Save uncommitted changes
git pull origin main
git stash pop  # Restore changes if needed
```

### PyPI Publishing Troubleshooting

#### Authentication Issues
- Verify `PYPI_API_TOKEN` in GitHub repository secrets
- Ensure token has upload permissions
- Check token format: `pypi-AgEIcHlw...`

#### Workflow Failures
- Check GitHub Actions logs for specific errors
- Verify `setup.py` syntax and version format
- Ensure all required files are committed

## 🎓 Development Best Practices

### Code Quality
- **Type Hints**: Use for all function parameters and returns
- **Error Handling**: Comprehensive try-catch blocks with user-friendly messages
- **Documentation**: Docstrings for all public methods
- **Testing**: Verify with sample files before release

### Version Control
- **Semantic Versioning**: MAJOR.MINOR.PATCH format
- **Meaningful Commits**: Clear, descriptive commit messages
- **Feature Branches**: Use for major changes (optional for solo development)
- **Tag Management**: Always tag releases for automated deployment

### User Experience
- **Clear Output**: Informative success/error messages
- **Progress Indicators**: For long-running operations
- **Flexible Input**: Support multiple file formats and options
- **Consistent CLI**: Follow standard command-line conventions

## 📞 Contact & Resources

- **Repository**: https://github.com/adamn1225/shift
- **PyPI Package**: https://pypi.org/project/shift-cli/
- **Issues**: Use GitHub Issues for bug reports and feature requests
- **Documentation**: README.md and this evolution guide

---

*Last Updated: September 10, 2025*
*Project Status: Active Development*
*Current Version: v1.0.5*

**Happy Coding! 🚀**
