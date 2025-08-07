# PowerShell wrapper for Shift Cloud CLI
# Allows PowerShell users to use: shift-cloud document.docx --to pdf

param(
    [Parameter(ValueFromRemainingArguments=$true)]
    [string[]]$Arguments
)

$ScriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
$PythonScript = Join-Path $ScriptPath "shift_cloud_cli.py"

& python $PythonScript @Arguments
