Function CopyFile($file, $dir, $force) {

    $fileName = [IO.Path]::GetFileName($file)
    $dstFile  = [IO.Path]::Combine($dir,  $fileName)
    Write-Host $dstFile
    Write-Host $force
    if ( (Test-Path  $dstFile) -And ($force -eq $false)) {
        return; 
    }
    Copy-Item -Path $file -Destination  $dir

}

$startPath = [IO.Path]::Combine($env:LOCALAPPDATA, "Packages")
$packagesDirs = Get-ChildItem -Path $startPath -Filter "Microsoft.WindowsTerminal*"
$terminalDir = $packagesDirs[0]
$settingsDir = [IO.Path]::Combine($terminalDir, "LocalState");
$settingsFile = [IO.Path]::Combine($scriptDataDir, "settings.json")
$srcFile = "$PSScriptRoot\settings.json"
$forceOberwrite = $false
Write-Host "SrcFile: $srcFile"
Write-Host "DstDir: $settingsDir "
Write-Host "ForceOberwrite: $settingsDir "
CopyFile  $settingsFile $settingsDir $forceOberwrite
