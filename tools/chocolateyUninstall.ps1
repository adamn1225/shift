$ErrorActionPreference = 'Stop'

$packageName = 'shift'
$toolsDir = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)"
$exeFile = Join-Path $toolsDir 'shift.exe'

Write-Host "Uninstalling Shift CLI tool..." -ForegroundColor Yellow

# Chocolatey automatically removes the shim when the package is uninstalled
# No additional cleanup needed for PATH or executables

Write-Host "✓ Shift CLI uninstalled successfully!" -ForegroundColor Green
