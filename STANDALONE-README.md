# 🚀 Shift CLI - Standalone Distribution

## ✅ What You Get

**No Python Required!** This is a completely standalone executable that includes everything needed to run Shift CLI.

### File: `shift.exe` (Windows) or `shift` (Linux/Mac)
- **Size**: ~115MB
- **Dependencies**: None! Everything is bundled
- **Requirements**: Just a modern Windows, Linux, or macOS system

## 📥 Installation Options

### Option 1: Download & Run Directly
1. Download the executable for your platform
2. Place it anywhere on your system
3. Run from command line: `./shift --help`

### Option 2: Add to PATH (Recommended)
1. Download the executable
2. Place in a permanent location (e.g., `C:\Tools\` on Windows)
3. Add that location to your system PATH
4. Now you can run `shift` from anywhere!

### Option 3: Quick Install Script

**Windows PowerShell:**
```powershell
# Download and install automatically
iwr -useb https://raw.githubusercontent.com/adamn1225/shift/main/install.ps1 | iex
```

**Windows Command Prompt (CMD):**
```cmd
# Download and install automatically  
powershell -c "iwr -useb https://raw.githubusercontent.com/adamn1225/shift/main/install.ps1 | iex"
```

## 🎯 Usage Examples

```bash
# Convert documents
shift document.docx --to pdf
shift report.md --to html --css style.css
shift presentation.pptx --to pdf

# PDF operations  
shift large-file.pdf --compress --quality screen
shift scanned-doc.pdf --ocr --language eng

# Batch processing
shift documents/ --batch --from docx --to pdf
```

## 🔧 Troubleshooting

### "Permission denied" or "Cannot run"
- **Linux/Mac**: Run `chmod +x shift` to make executable
- **Windows**: Right-click → Properties → Unblock if downloaded from internet

### "Command not found"
- Make sure the executable is in your PATH
- Or run with full path: `C:\path\to\shift.exe --help`

### Antivirus False Positives
- Some antivirus software flags PyInstaller executables
- This is a false positive - the executable is safe
- Add to your antivirus whitelist if needed

## 📊 File Information

- **Build Tool**: PyInstaller
- **Python Version**: 3.10
- **Architecture**: x64
- **Includes**: All dependencies (PyPDF, PIL, BeautifulSoup, etc.)

## 🏆 Advantages of Standalone

✅ **No Python installation required**  
✅ **No dependency management**  
✅ **Works offline**  
✅ **Single file distribution**  
✅ **Same functionality as pip version**  

Perfect for corporate environments, shared computers, or users who prefer simple installation!
