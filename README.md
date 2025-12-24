# Batch File Renamer

A PowerShell script for batch renaming files with a custom prefix and sequential numbering.

## Features

- Custom prefix for filenames
- Sequential numbering with configurable zero-padding
- Configurable start number
- File type filtering
- Preview mode (`-WhatIf`) to see changes before applying
- Colored console output for easy reading

## Installation

```bash
git clone https://github.com/YOUR_USERNAME/batch-rename.git
```

Or simply download `Rename-FilesSequentially.ps1` to your local machine.

## Usage

### Basic Syntax

```powershell
.\Rename-FilesSequentially.ps1 -Path <folder> -Prefix <prefix> [options]
```

### Parameters

| Parameter | Required | Default | Description |
|-----------|----------|---------|-------------|
| `-Path` | Yes | - | Folder containing files to rename |
| `-Prefix` | Yes | - | Prefix for new filenames |
| `-StartNumber` | No | 1 | Starting number for the sequence |
| `-Padding` | No | 3 | Number of digits (zero-padded) |
| `-Filter` | No | `*` | File filter (e.g., `*.png`, `*.jpg`) |
| `-WhatIf` | No | - | Preview changes without renaming |

### Examples

**Basic rename:**
```powershell
.\Rename-FilesSequentially.ps1 -Path "C:\Photos" -Prefix "vacation-"
# Results: vacation-001.jpg, vacation-002.jpg, etc.
```

**Start from a specific number:**
```powershell
.\Rename-FilesSequentially.ps1 -Path "D:\Assets" -Prefix "sprite-" -StartNumber 100
# Results: sprite-100.png, sprite-101.png, etc.
```

**Custom padding (4 digits):**
```powershell
.\Rename-FilesSequentially.ps1 -Path "C:\Images" -Prefix "img-" -Padding 4
# Results: img-0001.png, img-0002.png, etc.
```

**Filter specific file types:**
```powershell
.\Rename-FilesSequentially.ps1 -Path "C:\Mixed" -Prefix "photo-" -Filter "*.jpg"
# Only renames .jpg files
```

**Preview mode (dry run):**
```powershell
.\Rename-FilesSequentially.ps1 -Path "C:\Photos" -Prefix "test-" -WhatIf
# Shows what would happen without making changes
```

**Full example with all options:**
```powershell
.\Rename-FilesSequentially.ps1 `
    -Path "H:\My Drive\AI Strategy & Concepts\Midjourney Retro Cyberpunk Style" `
    -Prefix "midjourney-metaverse-" `
    -StartNumber 1 `
    -Padding 3 `
    -Filter "*.png"
```

## Output Example

```
📁 Folder: C:\Photos
📝 Prefix: vacation-
🔢 Starting at: 1 (padding: 3 digits)
📄 Files found: 5

  ✓ DSC_1234.jpg → vacation-001.jpg
  ✓ DSC_1235.jpg → vacation-002.jpg
  ✓ DSC_1236.jpg → vacation-003.jpg
  ✓ DSC_1237.jpg → vacation-004.jpg
  ✓ DSC_1238.jpg → vacation-005.jpg

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Complete: 5 file(s) renamed, 0 error(s)
```

## Tips

- **Always use `-WhatIf` first** to preview changes before committing
- Files are sorted alphabetically before renaming
- Original file extensions are preserved
- The script will not overwrite existing files with the same name (errors will be reported)

## Requirements

- Windows PowerShell 5.1+ or PowerShell Core 7+
- Write permissions to the target folder

## License

MIT License - feel free to use and modify as needed.