# Shift CLI - PowerShell One-liner Installer
# Usage: iwr -useb https://raw.githubusercontent.com/adamn1225/shift/main/install.ps1 | iex

$ErrorActionPreference = 'Stop'

Write-Host "🚀 Installing Shift CLI..." -ForegroundColor Cyan
Write-Host ""

$InstallationSuccessful = $false
$InstallMethod = ""

try {
    # Method 1: Try pip installation first (best option)
    if (-not $InstallationSuccessful -and (Get-Command python -ErrorAction SilentlyContinue)) {
        Write-Host "📦 Installing via pip..." -ForegroundColor Yellow
        python -m pip install shift 2>$null
        
        if ($LASTEXITCODE -eq 0) {
            Write-Host "✅ Shift CLI installed successfully via pip!" -ForegroundColor Green
            $InstallationSuccessful = $true
            $InstallMethod = "pip"
        }
    }
    
    # Method 2: Chocolatey installation
    if (-not $InstallationSuccessful -and (Get-Command choco -ErrorAction SilentlyContinue)) {
        Write-Host "🍫 Installing via Chocolatey..." -ForegroundColor Yellow
        choco install shift -y 2>$null
        
        if ($LASTEXITCODE -eq 0) {
            Write-Host "✅ Shift CLI installed successfully via Chocolatey!" -ForegroundColor Green
            $InstallationSuccessful = $true
            $InstallMethod = "Chocolatey"
        }
    }
    
    # Method 3: Direct download
    if (-not $InstallationSuccessful) {
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
            "https://github.com/adamn1225/shift/releases/download/v1.0.1/shift.exe"
        )
        
        $Downloaded = $false
        foreach ($DownloadUrl in $DownloadUrls) {
            try {
                Write-Host "Trying: $DownloadUrl" -ForegroundColor Gray
                Invoke-WebRequest -Uri $DownloadUrl -OutFile $ExePath -UseBasicParsing
                $Downloaded = $true
                Write-Host "✅ Downloaded successfully!" -ForegroundColor Green
                break
            }
            catch {
                Write-Host "Failed to download from $DownloadUrl" -ForegroundColor Gray
            }
        }
        
        if ($Downloaded) {
            # Add to PATH
            $CurrentPath = [Environment]::GetEnvironmentVariable("Path", "User")
            if ($CurrentPath -notlike "*$InstallDir*") {
                [Environment]::SetEnvironmentVariable("Path", "$CurrentPath;$InstallDir", "User")
                Write-Host "📝 Added to PATH." -ForegroundColor Yellow
            }
            
            $InstallationSuccessful = $true
            $InstallMethod = "direct download"
        }
        else {
            throw "Could not download executable from any release URL"
        }
    }
    
}
catch {
    Write-Host "❌ Installation failed: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host ""
    Write-Host "Manual installation options:" -ForegroundColor Yellow
    Write-Host "1. pip install shift" -ForegroundColor White
    Write-Host "2. choco install shift" -ForegroundColor White
    Write-Host "3. Download from: https://github.com/adamn1225/shift/releases" -ForegroundColor White
}

# Final status message
if ($InstallationSuccessful) {
    Write-Host ""
    Write-Host "🎉 Installation completed via $InstallMethod!" -ForegroundColor Green
    Write-Host ""
    Write-Host "Usage examples:" -ForegroundColor White
    Write-Host "  shift document.docx --to pdf" -ForegroundColor Cyan
    Write-Host "  shift report.md --to html" -ForegroundColor Cyan
    Write-Host "  shift --help" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "💡 Try running 'shift --help' to get started!" -ForegroundColor Yellow
}
else {
    Write-Host ""
    Write-Host "❌ Installation was not successful." -ForegroundColor Red
    Write-Host "Please try the manual installation options above." -ForegroundColor White
}

Write-Host ""
Write-Host "Press any key to continue or close this window..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
