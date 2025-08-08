@echo off
REM Shift CLI - CMD/Batch Installer
REM Usage: Download and run this batch file, or run:
REM curl -L https://raw.githubusercontent.com/adamn1225/shift/main/install-cmd.bat -o install-shift.bat && install-shift.bat

echo.
echo ==========================================
echo   Shift CLI - Windows Installer
echo ==========================================
echo.

REM Check if PowerShell is available (it should be on Windows 7+)
powershell -Command "Get-Host" >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: PowerShell is required but not found.
    echo Please install PowerShell or use a newer version of Windows.
    pause
    exit /b 1
)

echo Running PowerShell installer...
echo.

REM Run the PowerShell installation script
powershell -ExecutionPolicy Bypass -Command "iwr -useb https://raw.githubusercontent.com/adamn1225/shift/main/install.ps1 | iex"

if %ERRORLEVEL% EQ 0 (
    echo.
    echo ========================================
    echo   Installation Complete!
    echo ========================================
    echo.
    echo You can now use 'shift' from any command prompt or PowerShell window.
    echo.
    echo Usage examples:
    echo   shift document.docx --to pdf
    echo   shift report.md --to html
    echo   shift --help
    echo.
) else (
    echo.
    echo Installation failed. Please try manual installation:
    echo 1. Download from: https://github.com/adamn1225/shift/releases
    echo 2. Or use PowerShell: iwr -useb https://raw.githubusercontent.com/adamn1225/shift/main/install.ps1 ^| iex
    echo.
)

pause
