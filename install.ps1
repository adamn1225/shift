# Shift CLI - PowerShell One-liner Installer
# Usage: iwr -useb https://raw.githubusercontent.com/adamn1225/shift/main/install.ps1 | iex

$ErrorActionPreference = 'Stop'

Write-Host "🚀 Installing Shift CLI..." -ForegroundColor Cyan

try {
    # Method 1: Try pip installation first (best option)
    if (Get-Command python -ErrorAction SilentlyContinue) {
        Write-Host "📦 Installing via pip..." -ForegroundColor Yellow
        python -m pip install shift
        
        if ($LASTEXITCODE -eq 0) {
            Write-Host "✅ Shift CLI installed successfully via pip!" -ForegroundColor Green
            Write-Host "Usage: shift document.docx --to pdf" -ForegroundColor White
            return
        }
    }
    
    # Method 2: Chocolatey installation
    if (Get-Command choco -ErrorAction SilentlyContinue) {
        Write-Host "🍫 Installing via Chocolatey..." -ForegroundColor Yellow
        choco install shift -y
        
        if ($LASTEXITCODE -eq 0) {
            Write-Host "✅ Shift CLI installed successfully via Chocolatey!" -ForegroundColor Green
            return
        }
    }
    
    # Method 3: Direct download
    Write-Host "⬇️ Downloading standalone executable..." -ForegroundColor Yellow
    
    $InstallDir = "$env:USERPROFILE\shift-cli"
    if (!(Test-Path $InstallDir)) {
        New-Item -ItemType Directory -Path $InstallDir -Force | Out-Null
    }
    
    $ExePath = "$InstallDir\shift.exe"
    
    # Try multiple download URLs (in case release naming changes)
    $DownloadUrls = @(
        "https://github.com/adamn1225/shift/releases/latest/download/shift.exe",
        "https://github.com/adamn1225/shift/releases/latest/download/shift-windows.exe",
        "https://github.com/adamn1225/shift/releases/download/v1.0.0/shift.exe"
    )
    
    $Downloaded = $false
    foreach ($DownloadUrl in $DownloadUrls) {
        try {
            Write-Host "Trying: $DownloadUrl" -ForegroundColor Gray
            Invoke-WebRequest -Uri $DownloadUrl -OutFile $ExePath -UseBasicParsing
            $Downloaded = $true
            break
        }
        catch {
            Write-Host "Failed to download from $DownloadUrl" -ForegroundColor Gray
        }
    }
    
    if (-not $Downloaded) {
        throw "Could not download executable from any release URL"
    }
    
    # Add to PATH
    $CurrentPath = [Environment]::GetEnvironmentVariable("Path", "User")
    if ($CurrentPath -notlike "*$InstallDir*") {
        [Environment]::SetEnvironmentVariable("Path", "$CurrentPath;$InstallDir", "User")
        Write-Host "📝 Added to PATH. Restart your terminal to use 'shift' commands." -ForegroundColor Yellow
    }
    
    Write-Host "✅ Shift CLI installed successfully!" -ForegroundColor Green
    Write-Host "Location: $ExePath" -ForegroundColor Gray
    Write-Host "Usage: shift document.docx --to pdf" -ForegroundColor White
    
}
catch {
    Write-Error "❌ Installation failed: $($_.Exception.Message)"
    Write-Host ""
    Write-Host "Manual installation options:" -ForegroundColor Yellow
    Write-Host "1. pip install shift" -ForegroundColor White
    Write-Host "2. choco install shift" -ForegroundColor White
    Write-Host "3. Download from: https://github.com/adamn1225/shift/releases" -ForegroundColor White
}
