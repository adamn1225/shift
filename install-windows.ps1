# PowerShell installation script for Shift Cloud CLI
# Run with: Set-ExecutionPolicy Bypass -Scope Process; .\install-windows.ps1

param(
    [string]$InstallDir = "$env:USERPROFILE\shift-cloud",
    [string]$ServiceUrl = $null
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

# Download URLs
$BaseUrl = "https://github.com/yourusername/shift/releases/latest/download"
$ZipUrl = "$BaseUrl/shift-cloud-windows.zip"
$ZipPath = "$InstallDir\shift-cloud.zip"

try {
    Write-Host "📥 Downloading latest version..." -ForegroundColor Yellow
    Invoke-WebRequest -Uri $ZipUrl -OutFile $ZipPath -UseBasicParsing
    
    Write-Host "📦 Extracting files..." -ForegroundColor Yellow
    Expand-Archive -Path $ZipPath -DestinationPath $InstallDir -Force
    
    # Clean up zip file
    Remove-Item $ZipPath
    
    # Add to user PATH
    Write-Host "🔧 Adding to PATH..." -ForegroundColor Yellow
    $CurrentPath = [Environment]::GetEnvironmentVariable("PATH", "User")
    if ($CurrentPath -notlike "*$InstallDir*") {
        $NewPath = "$CurrentPath;$InstallDir"
        [Environment]::SetEnvironmentVariable("PATH", $NewPath, "User")
        Write-Host "✅ Added to user PATH" -ForegroundColor Green
    } else {
        Write-Host "✅ Already in PATH" -ForegroundColor Green
    }
    
    # Set service URL if provided
    if ($ServiceUrl) {
        [Environment]::SetEnvironmentVariable("SHIFT_SERVICE_URL", $ServiceUrl, "User")
        Write-Host "✅ Set service URL: $ServiceUrl" -ForegroundColor Green
    }
    
    Write-Host ""
    Write-Host "==========================================" -ForegroundColor Green
    Write-Host "   Installation Complete! ✅" -ForegroundColor Green
    Write-Host "==========================================" -ForegroundColor Green
    Write-Host ""
    Write-Host "Installation directory: $InstallDir" -ForegroundColor White
    Write-Host ""
    Write-Host "Usage:" -ForegroundColor White
    Write-Host "  shift-cloud document.docx --to pdf" -ForegroundColor Cyan
    Write-Host "  shift-cloud report.md --to html" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Note: Restart PowerShell to use the new PATH" -ForegroundColor Yellow
    Write-Host ""
    
} catch {
    Write-Host ""
    Write-Host "❌ Installation failed: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host ""
    Write-Host "Manual installation options:" -ForegroundColor Yellow
    Write-Host "1. Download from: https://github.com/yourusername/shift/releases/latest" -ForegroundColor White
    Write-Host "2. Install via Python: pip install shift-cloud-cli" -ForegroundColor White
    Write-Host ""
}
