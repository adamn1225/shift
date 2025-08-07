# PowerShell installation script for Shift Cloud CLI
# Run with: iwr -useb https://raw.githubusercontent.com/adamn1225/shift/main/install-windows.ps1 | iex

param(
    [string]$InstallDir = "$env:USERPROFILE\shift-cloud",
    [string]$ServiceUrl = "https://shift-api.adamn1225.repl.co"
)

Write-Host ""
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "   Shift Cloud CLI - PowerShell Installer" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""

# Create installation directory
if (!(Test-Path $InstallDir)) {
    New-Item -ItemType Directory -Path $InstallDir -Force | Out-Null
}

Write-Host "Installing to: $InstallDir" -ForegroundColor Green
Write-Host ""

try {
    Write-Host "📥 Downloading PowerShell module..." -ForegroundColor Yellow
    
    # Download the PowerShell module
    $moduleUrl = "https://raw.githubusercontent.com/adamn1225/shift/main/Shift.psm1"
    $modulePath = "$InstallDir\Shift.psm1"
    Invoke-WebRequest -Uri $moduleUrl -OutFile $modulePath -UseBasicParsing
    
    Write-Host "📦 Installing module..." -ForegroundColor Yellow
    
    # Create PowerShell modules directory if it doesn't exist
    $userModulePath = "$env:USERPROFILE\Documents\PowerShell\Modules\Shift"
    if (!(Test-Path $userModulePath)) {
        New-Item -ItemType Directory -Path $userModulePath -Force | Out-Null
    }
    
    # Copy module to PowerShell modules directory
    Copy-Item $modulePath $userModulePath -Force
    
    Write-Host "✅ Installation complete!" -ForegroundColor Green
    Write-Host ""
    Write-Host "Usage examples:" -ForegroundColor Yellow
    Write-Host "  shift-convert document.docx -To pdf" -ForegroundColor White
    Write-Host "  shift-compress large.pdf" -ForegroundColor White
    Write-Host "  shift-ocr scanned.pdf" -ForegroundColor White
    Write-Host ""
    Write-Host "Import the module now:" -ForegroundColor Yellow
    Write-Host "  Import-Module Shift" -ForegroundColor White
    
}
catch {
    Write-Error "Installation failed: $($_.Exception.Message)"
    Write-Host ""
    Write-Host "Manual installation:" -ForegroundColor Yellow
    Write-Host "1. Download: https://raw.githubusercontent.com/adamn1225/shift/main/Shift.psm1"
    Write-Host "2. Save to: $userModulePath\Shift.psm1"
    Write-Host "3. Run: Import-Module Shift"
}
