$folder = "H:\My Drive\Photos"
$files = Get-ChildItem -Path $folder -File | Sort-Object Name
$counter = 1

foreach ($file in $files) {
    $extension = $file.Extension
    $newName = "photo-{0:D3}{1}" -f $counter, $extension
    Rename-Item -Path $file.FullName -NewName $newName
    Write-Host "Renamed: $($file.Name) -> $newName"
    $counter++
}