<#
.SYNOPSIS
    Batch rename files in a folder with a custom prefix and sequential numbering.

.DESCRIPTION
    This script renames all files in a specified folder using a custom prefix
    followed by sequential numbers. Supports configurable padding, start number,
    and file filtering.

.PARAMETER Path
    The folder path containing files to rename.

.PARAMETER Prefix
    The prefix for the new filenames (e.g., "midjourney-metaverse-").

.PARAMETER StartNumber
    The starting number for sequential numbering. Default is 1.

.PARAMETER Padding
    Number of digits for zero-padding. Default is 3 (e.g., 001, 002).

.PARAMETER Filter
    Optional file filter pattern (e.g., "*.png", "*.jpg"). Default is all files.

.PARAMETER WhatIf
    Preview changes without actually renaming files.

.EXAMPLE
    .\Rename-FilesSequentially.ps1 -Path "C:\Images" -Prefix "photo-"
    
.EXAMPLE
    .\Rename-FilesSequentially.ps1 -Path "D:\Project" -Prefix "asset-" -StartNumber 100 -Padding 4

.EXAMPLE
    .\Rename-FilesSequentially.ps1 -Path "C:\Images" -Prefix "img-" -Filter "*.png" -WhatIf
#>

param(
    [Parameter(Mandatory = $true, HelpMessage = "Folder path containing files to rename")]
    [string]$Path,

    [Parameter(Mandatory = $true, HelpMessage = "Prefix for new filenames")]
    [string]$Prefix,

    [Parameter(HelpMessage = "Starting number for sequence")]
    [int]$StartNumber = 1,

    [Parameter(HelpMessage = "Zero-padding width")]
    [int]$Padding = 3,

    [Parameter(HelpMessage = "File filter pattern (e.g., *.png)")]
    [string]$Filter = "*",

    [Parameter(HelpMessage = "Preview changes without renaming")]
    [switch]$WhatIf
)

# Validate path exists
if (-not (Test-Path -Path $Path -PathType Container)) {
    Write-Error "The specified path does not exist or is not a folder: $Path"
    exit 1
}

# Get files matching filter, sorted by name
$files = Get-ChildItem -Path $Path -File -Filter $Filter | Sort-Object Name

if ($files.Count -eq 0) {
    Write-Warning "No files found matching filter '$Filter' in: $Path"
    exit 0
}

Write-Host "`n📁 Folder: $Path" -ForegroundColor Cyan
Write-Host "📝 Prefix: $Prefix" -ForegroundColor Cyan
Write-Host "🔢 Starting at: $StartNumber (padding: $Padding digits)" -ForegroundColor Cyan
Write-Host "📄 Files found: $($files.Count)`n" -ForegroundColor Cyan

if ($WhatIf) {
    Write-Host "⚠️  PREVIEW MODE - No files will be renamed`n" -ForegroundColor Yellow
}

$counter = $StartNumber
$renamed = 0
$errors = 0

foreach ($file in $files) {
    $extension = $file.Extension
    $formatString = "{0}{1:D$Padding}{2}"
    $newName = $formatString -f $Prefix, $counter, $extension
    
    try {
        if ($WhatIf) {
            Write-Host "  $($file.Name) → $newName" -ForegroundColor Gray
        } else {
            Rename-Item -Path $file.FullName -NewName $newName -ErrorAction Stop
            Write-Host "  ✓ $($file.Name) → $newName" -ForegroundColor Green
        }
        $renamed++
    } catch {
        Write-Host "  ✗ Failed: $($file.Name) - $($_.Exception.Message)" -ForegroundColor Red
        $errors++
    }
    
    $counter++
}

Write-Host "`n━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor DarkGray
if ($WhatIf) {
    Write-Host "Preview complete: $renamed file(s) would be renamed" -ForegroundColor Yellow
} else {
    Write-Host "Complete: $renamed file(s) renamed, $errors error(s)" -ForegroundColor $(if ($errors -eq 0) { "Green" } else { "Yellow" })
}