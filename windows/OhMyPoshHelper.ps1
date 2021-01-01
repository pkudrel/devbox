[CmdletBinding()]
Param(
    [switch]$Install,
    [switch]$ListThemes,
    [switch]$Force
)

$OhMyPosh = "$env:LOCALAPPDATA\Oh-My-Posh"
$OhMyPoshExe = Join-Path $OhMyPosh "oh-my-posh.exe"
$OhMyPoshThemes = "~\.poshthemes"
$OhMyPoshZip = Join-Path $OhMyPoshThemes "themes.zip"

if(!$Install.IsPresent -and !$ListThemes.IsPresent) {
    Write-Host
    Write-Host "Usage:" -ForegroundColor Yellow
    Get-Help $PSCommandPath
}

if($Install.IsPresent) {
    if(!(Test-Path $OhMyPoshExe) -or $Force.IsPresent) {
        Write-Host "Downloading Oh-My-Posh..."
        New-Item -Path $env:LOCALAPPDATA\Oh-My-Posh -ItemType Directory -ErrorAction Ignore

        if(Test-Path $OhMyPoshExe) {
            Remove-Item $OhMyPoshExe
        }

        Invoke-Webrequest https://github.com/JanDeDobbeleer/oh-my-posh3/releases/latest/download/posh-windows-amd64.exe -OutFile $OhMyPoshExe
    } else {
        Write-Debug "Oh-My-Posh already installed"
    }
    
    $CurrentPath = [System.Environment]::GetEnvironmentVariable("PATH", "User");
    if(!($CurrentPath -like "*$OhMyPosh*")) {
        Write-Host "Setting PATH variable..."
        [Environment]::SetEnvironmentVariable("PATH", "$CurrentPath;$OhMyPosh", "User")
    } else {
        Write-Debug "PATH variable already set"
    }

    if(!(Test-Path $OhMyPoshThemes) -or $Force.IsPresent) {
        New-Item -Path $OhMyPoshThemes -ItemType Directory -ErrorAction Ignore
        Write-Host "Downloading Oh-My-Posh themes..."
        Invoke-Webrequest https://github.com/JanDeDobbeleer/oh-my-posh3/releases/latest/download/themes.zip -OutFile $OhMyPoshZip
        Expand-Archive $OhMyPoshZip -DestinationPath $OhMyPoshThemes -Force
        Remove-Item $OhMyPoshZip
    } else {
        Write-Debug "Oh-My-Posh themes already installed"
    }
}

if($ListThemes.IsPresent) {
    Get-ChildItem -Path "$OhMyPoshThemes\*" -Include '*.omp.json' | Sort-Object Name | ForEach-Object -Process {
        $esc = [char]27
        Write-Host ""
        Write-Host "--$esc[1m$($_.BaseName)$esc[0m----------------------"
        &$OhMyPoshExe -config $($_.FullName) -pwd $PWD
        Write-Host ""
    }
} else {
    Write-Error "Oh-My-Posh themes not installed"
}
