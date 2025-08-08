@echo off
REM Windows installation script for Shift CLI
REM Downloads and installs the latest version from GitHub

echo.
echo ==========================================
echo   Shift CLI - Windows Installer
echo ==========================================
echo.

REM Check if Python is installed first
python --version >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo Python is not installed or not in PATH.
    echo.
    echo Option 1: Install Python first
    echo   Download from: https://python.org
    echo   Make sure to check "Add Python to PATH"
    echo.
    echo Option 2: Use standalone executable
    echo   Will download pre-built executable...
    choice /c YN /m "Continue with standalone executable? (Y/N)"
    if %ERRORLEVEL% NEQ 1 goto :python_install
) else (
    echo Python found. Installing via pip...
    pip install shift
    if %ERRORLEVEL% EQ 0 (
        echo.
        echo ✓ Shift CLI installed successfully via pip!
        echo Usage: shift document.docx --to pdf
        goto :end
    )
)

:python_install
REM Create installation directory
set INSTALL_DIR=%USERPROFILE%\shift-cli
if not exist "%INSTALL_DIR%" mkdir "%INSTALL_DIR%"

echo Installing to: %INSTALL_DIR%
echo.

REM Download using PowerShell
echo Downloading latest version...
powershell -Command "& {Invoke-WebRequest -Uri 'https://github.com/adamn1225/shift/releases/latest/download/shift-windows.exe' -OutFile '%INSTALL_DIR%\shift.exe'}"

if %errorlevel% neq 0 (
    echo.
    echo ERROR: Download failed. Please check your internet connection.
    echo Alternatively, download manually from:
    echo https://github.com/adamn1225/shift/releases/latest
    pause
    exit /b 1
)

REM Add to PATH (user level)
echo Adding to PATH...
setx PATH "%PATH%;%INSTALL_DIR%" >nul

echo.
echo ========================================
echo   Installation Complete!
echo ========================================
echo.
echo Installation directory: %INSTALL_DIR%
echo.
echo Usage:
echo   shift document.docx --to pdf
echo   shift report.md --to html
echo   shift --help
echo.
echo Note: Restart your command prompt to use the new PATH

:end
echo.
pause
