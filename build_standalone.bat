@echo off
echo 🚀 Building Shift CLI standalone executable for Windows...
echo.

REM Check if PyInstaller is installed
python -c "import PyInstaller" 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo 📦 Installing PyInstaller...
    pip install pyinstaller
)

REM Clean previous builds
echo 🧹 Cleaning previous builds...
if exist build rmdir /s /q build
if exist dist rmdir /s /q dist

REM Build Windows executable
echo 🪟 Building Windows executable...
pyinstaller --clean shift.spec

REM Check if build was successful
if exist "dist\shift.exe" (
    echo ✅ Build successful!
    echo.
    echo 📁 Files created:
    dir dist
    echo.
    echo 🎯 Ready for distribution: dist\shift.exe
    echo.
    
    REM Create distribution archive
    echo 📦 Creating distribution archive...
    powershell -Command "Compress-Archive -Path 'dist\shift.exe' -DestinationPath 'dist\shift-windows.zip' -Force"
    echo ✅ Created: dist\shift-windows.zip
    echo.
    
    echo 🎉 Standalone executable build complete!
    echo.
    echo 📋 Next steps:
    echo 1. Test the executable: dist\shift.exe --help
    echo 2. Upload dist\shift.exe to GitHub releases
    echo 3. Update Chocolatey package tools\shift.exe
    echo 4. Update download links in install scripts
) else (
    echo ❌ Build failed!
    echo Check the output above for errors.
    pause
    exit /b 1
)

echo.
pause
