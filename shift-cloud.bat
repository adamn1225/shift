@echo off
REM Windows batch wrapper for Shift Cloud CLI
REM Allows Windows users to use: shift-cloud document.docx --to pdf

python "%~dp0shift_cloud_cli.py" %*
