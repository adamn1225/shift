# Shift PowerShell Module
# Save as Shift.psm1

function Invoke-Shift {
    param(
        [Parameter(Mandatory=$true, Position=0)]
        [string]$InputFile,
        
        [Parameter(Mandatory=$true)]
        [string]$To,
        
        [string]$From,
        [string]$Output,
        [string]$Css,
        [switch]$Batch,
        [switch]$IgnoreLinks
    )
    
    # Build command arguments
    $args = @($InputFile, "--to", $To)
    
    if ($From) { $args += @("--from", $From) }
    if ($Output) { $args += @("--output", $Output) }
    if ($Css) { $args += @("--css", $Css) }
    if ($Batch) { $args += "--batch" }
    if ($IgnoreLinks) { $args += "--ignore-links" }
    
    # Run the Python script
    python "$PSScriptRoot\doc_converter.py" @args
}

# Create aliases for common usage
Set-Alias -Name "shift" -Value "Invoke-Shift"

# Export functions
Export-ModuleMember -Function Invoke-Shift -Alias shift
