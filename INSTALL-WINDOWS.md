# 🚀 Installation Guide

## Quick Install (Windows Users)

### Method 1: Python pip (Recommended)
```cmd
pip install shift
```

### Method 2: Chocolatey
```cmd
choco install shift
```

### Method 3: One-liner PowerShell
```powershell
iwr -useb https://raw.githubusercontent.com/adamn1225/shift/main/install.ps1 | iex
```

### Method 4: WinGet (Microsoft Store)
```cmd
winget install adamn1225.shift
```

### Method 5: Scoop
```cmd
scoop bucket add extras
scoop install shift
```

### Method 6: Direct Download
1. Download `shift.exe` from [Releases](https://github.com/adamn1225/shift/releases/latest)
2. Add to your PATH or place in a folder that's in PATH

## Usage Examples

```cmd
# Convert documents
shift document.docx --to pdf
shift report.md --to html --css style.css
shift file.pdf --to text

# Compress PDFs
shift-compress large-file.pdf --quality screen

# Extract text with OCR
shift-ocr scanned-document.pdf

# Batch convert
shift folder/ --batch --from docx --to pdf
```

## Verification

After installation, verify it works:
```cmd
shift --help
shift --version
```

## Troubleshooting

- **"command not found"**: Restart your terminal after installation
- **Python errors**: Make sure Python 3.8+ is installed
- **Permission errors**: Run terminal as administrator for system-wide install
