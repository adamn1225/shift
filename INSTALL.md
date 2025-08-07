# 🚀 Shift Cloud CLI - One-Line Installation

## Windows

### Option 1: PowerShell (Recommended)
```powershell
# Download and run installer
iwr "https://raw.githubusercontent.com/yourusername/shift/main/install-windows.ps1" | iex
```

### Option 2: Command Prompt
```cmd
# Download installer and run
curl -o install.bat "https://raw.githubusercontent.com/yourusername/shift/main/install-windows.bat" && install.bat
```

### Option 3: Manual Download
```powershell
# Direct download using PowerShell
Invoke-WebRequest -Uri "https://github.com/yourusername/shift/releases/latest/download/shift-cloud-windows.zip" -OutFile "shift-cloud.zip"
Expand-Archive shift-cloud.zip -DestinationPath .
```

## Linux/macOS

### Option 1: curl (Recommended)
```bash
# Download and run installer
curl -fsSL https://raw.githubusercontent.com/yourusername/shift/main/install-unix.sh | bash
```

### Option 2: wget
```bash
# Download and run installer
wget -qO- https://raw.githubusercontent.com/yourusername/shift/main/install-unix.sh | bash
```

### Option 3: Manual Download
```bash
# Linux
curl -L -o shift-cloud "https://github.com/yourusername/shift/releases/latest/download/shift-cloud-linux-x64"
chmod +x shift-cloud

# macOS
curl -L -o shift-cloud "https://github.com/yourusername/shift/releases/latest/download/shift-cloud-macos-x64"
chmod +x shift-cloud
```

## Universal: Python Package

Works on all platforms with Python:

```bash
pip install shift-cloud-cli
```

## Universal: Docker

Works anywhere Docker runs:

```bash
# One-time setup
docker pull yourusername/shift-cloud

# Use as command
docker run --rm -v $(pwd):/workspace yourusername/shift-cloud document.docx --to pdf
```

## Usage After Installation

```bash
# Convert documents
shift-cloud document.docx --to pdf
shift-cloud report.md --to html
shift-cloud presentation.html --to pdf

# Set custom service URL
export SHIFT_SERVICE_URL="https://your-service.run.app"
shift-cloud document.docx --to pdf
```

## Windows-Specific Notes

- **PowerShell**: Built into Windows 10/11, most reliable
- **curl**: Available in Windows 10+ by default
- **wget**: Not built-in, but available via Chocolatey/WSL
- **Download methods ranked by reliability**:
  1. PowerShell `Invoke-WebRequest` ✅ (always works)
  2. `curl` ✅ (Windows 10+)
  3. `wget` ⚠️ (only if installed)

So **yes, wget can work on Windows**, but PowerShell or curl are more reliable since they're built-in!
