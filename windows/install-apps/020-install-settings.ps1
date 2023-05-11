
$app = $env:LOCALAPPDATA;

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

$scriptPath = $MyInvocation.MyCommand.Path
$scriptDir = Split-Path $scriptPath -Parent
$scriptDataDir = [IO.Path]::Combine($scriptDir, "data")

$aapMiscHome = [IO.Path]::Combine($env:LOCALAPPDATA, "AntiPiracy", 'misc')
[System.IO.Directory]::CreateDirectory($aapMiscHome)


# Theme file
$themeFile = [IO.Path]::Combine($scriptDataDir, "paradox.omp.json")
CopyFile  $themeFile $aapMiscHome $false
Write-Host $themeFile   

# Profile file
$profileDir = Split-Path $PROFILE -Parent
$srcProfileFile = [IO.Path]::Combine($scriptDataDir, "Microsoft.PowerShell_profile.ps1")
CopyFile  $srcProfileFile $profileDir $false
Write-Host $srcProfileFile


$startPath = [IO.Path]::Combine($env:LOCALAPPDATA, "Packages")
$packagesDirs = Get-ChildItem -Path $startPath -Filter "Microsoft.WindowsTerminal*"
$terminalDir = $packagesDirs[0]
$settingsDir = [IO.Path]::Combine($terminalDir, "LocalState");
$settingsFile = [IO.Path]::Combine($scriptDataDir, "settings.json")
CopyFile  $settingsFile $settingsDir $false
Write-Host $settingsFile