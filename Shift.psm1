# Shift Cloud CLI - PowerShell Module for Windows

$ShiftServiceUrl = "https://shift-api.adamn1225.repl.co"

function Invoke-ShiftConvert {
    param(
        [Parameter(Mandatory = $true)]
        [string]$InputFile,
        
        [Parameter(Mandatory = $true)]
        [string]$To,
        
        [string]$Output
    )
    
    if (!(Test-Path $InputFile)) {
        Write-Error "File not found: $InputFile"
        return
    }
    
    Write-Host "🔄 Converting $InputFile to $To..." -ForegroundColor Yellow
    
    try {
        # Create multipart form data
        $form = @{
            file          = Get-Item $InputFile
            target_format = $To
        }
        
        $response = Invoke-RestMethod -Uri "$ShiftServiceUrl/convert" -Method Post -Form $form
        
        if ($Output) {
            [System.IO.File]::WriteAllBytes($Output, $response)
            Write-Host "✅ Saved to: $Output" -ForegroundColor Green
        }
        else {
            # Generate output filename
            $baseName = [System.IO.Path]::GetFileNameWithoutExtension($InputFile)
            $outputFile = "$baseName.$To"
            [System.IO.File]::WriteAllBytes($outputFile, $response)
            Write-Host "✅ Saved to: $outputFile" -ForegroundColor Green
        }
    }
    catch {
        Write-Error "Conversion failed: $($_.Exception.Message)"
    }
}

function Invoke-ShiftCompress {
    param(
        [Parameter(Mandatory = $true)]
        [string]$InputFile,
        
        [string]$Output,
        [string]$Quality = "ebook"
    )
    
    if (!(Test-Path $InputFile)) {
        Write-Error "File not found: $InputFile"
        return
    }
    
    Write-Host "🗜️ Compressing $InputFile..." -ForegroundColor Yellow
    
    try {
        $form = @{
            file    = Get-Item $InputFile
            quality = $Quality
        }
        
        $response = Invoke-RestMethod -Uri "$ShiftServiceUrl/compress" -Method Post -Form $form
        
        if ($Output) {
            $outputFile = $Output
        }
        else {
            $baseName = [System.IO.Path]::GetFileNameWithoutExtension($InputFile)
            $outputFile = "${baseName}_compressed.pdf"
        }
        
        [System.IO.File]::WriteAllBytes($outputFile, $response)
        Write-Host "✅ Compressed and saved to: $outputFile" -ForegroundColor Green
    }
    catch {
        Write-Error "Compression failed: $($_.Exception.Message)"
    }
}

function Invoke-ShiftOCR {
    param(
        [Parameter(Mandatory = $true)]
        [string]$InputFile,
        
        [string]$Output,
        [string]$Language = "eng"
    )
    
    if (!(Test-Path $InputFile)) {
        Write-Error "File not found: $InputFile"
        return
    }
    
    Write-Host "🔍 Extracting text from $InputFile..." -ForegroundColor Yellow
    
    try {
        $form = @{
            file     = Get-Item $InputFile
            language = $Language
        }
        
        $text = Invoke-RestMethod -Uri "$ShiftServiceUrl/ocr" -Method Post -Form $form
        
        if ($Output) {
            $text | Out-File $Output -Encoding UTF8
            Write-Host "✅ Text saved to: $Output" -ForegroundColor Green
        }
        else {
            Write-Host $text
        }
    }
    catch {
        Write-Error "OCR failed: $($_.Exception.Message)"
    }
}

# Create aliases for familiar command names
Set-Alias -Name "shift-convert" -Value "Invoke-ShiftConvert"
Set-Alias -Name "shift-compress" -Value "Invoke-ShiftCompress"
Set-Alias -Name "shift-ocr" -Value "Invoke-ShiftOCR"

Export-ModuleMember -Function * -Alias *
