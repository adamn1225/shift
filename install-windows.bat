@echo off
REM Windows installation script for Shift Cloud CLI
REM Downloads and installs the latest version from GitHub

echo.
echo ==========================================
echo   Shift Cloud CLI - Windows Installer
echo ==========================================
echo.

REM Check if we're running as admin (optional)
net session >nul 2>&1
if %errorLevel% == 0 (
    echo Running as administrator...
) else (
    echo Running as regular user...
)

REM Create installation directory
set INSTALL_DIR=%USERPROFILE%\shift-cloud
if not exist "%INSTALL_DIR%" mkdir "%INSTALL_DIR%"

echo Installing to: %INSTALL_DIR%
echo.

REM Download using PowerShell (most reliable on Windows)
echo Downloading latest version...
powershell -Command "& {Invoke-WebRequest -Uri 'https://github.com/yourusername/shift/releases/latest/download/shift-cloud-windows.zip' -OutFile '%INSTALL_DIR%\shift-cloud.zip'}"

if %errorlevel% neq 0 (
    echo.
    echo ERROR: Download failed. Please check your internet connection.
    echo Alternatively, download manually from:
    echo https://github.com/yourusername/shift/releases/latest
    pause
    exit /b 1
)

REM Extract (using PowerShell)
echo Extracting files...
powershell -Command "& {Expand-Archive -Path '%INSTALL_DIR%\shift-cloud.zip' -DestinationPath '%INSTALL_DIR%' -Force}"

REM Clean up zip file
del "%INSTALL_DIR%\shift-cloud.zip"

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
echo   shift-cloud document.docx --to pdf
echo   shift-cloud report.md --to html
echo.
echo Note: Restart your command prompt to use the new PATH
echo.
pause
