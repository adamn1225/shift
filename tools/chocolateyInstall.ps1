$ErrorActionPreference = 'Stop'

$packageName = 'shift'
$toolsDir = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"
$exeFile = Join-Path $toolsDir 'shift.exe'

Write-Host "Installing Shift CLI tool..." -ForegroundColor Green

# Verify the executable exists
if (!(Test-Path $exeFile)) {
    throw "shift.exe not found in tools directory: $toolsDir"
}

# Create a shim for the executable (Chocolatey handles this automatically)
# The executable will be available as 'shift' in the PATH

Write-Host "✓ Shift CLI installed successfully!" -ForegroundColor Green
Write-Host "Usage: shift document.docx --to pdf" -ForegroundColor Yellow
Write-Host "Help:  shift --help" -ForegroundColor Yellow
