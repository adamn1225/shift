#!/bin/bash
# Unix/Linux/macOS wrapper for Shift Cloud CLI
# Allows bash users to use: shift-cloud document.docx --to pdf

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
python3 "$SCRIPT_DIR/shift_cloud_cli.py" "$@"
