# file: C:\Users\piotr\Documents\PowerShell\profile.ps1

######
###### INSTALL
######

# Clone https://github.com/pkudrel/devbox to W:\DenebLab\devbox

# Add oh-my-posh and Paradox theme
# INSTALL: winget install JanDeDobbeleer.OhMyPosh -s winget
# UPGRADE: winget upgrade JanDeDobbeleer.OhMyPosh -s winget

## posh-git
# PowerShellGet\Install-Module posh-git -Scope CurrentUser -Force

## Terminal-Icons
# Install-Module -Name Terminal-Icons -Repository PSGallery

## DockerCompletion
# Install-Module DockerCompletion -Scope CurrentUser

[console]::InputEncoding = [console]::OutputEncoding = [System.Text.UTF8Encoding]::new()

# helpers
$workDir = "$env:USERPROFILE\!work"

function Import-Module-With-Measure {  
    param ($ModuleName)
    $import = Measure-Command {
        Import-Module $ModuleName
    } 
    Write-Host "$ModuleName import $([Math]::Round($import.TotalMilliseconds)) ms"
}


Import-Module-With-Measure posh-git
$env:POSH_GIT_ENABLED = $true
Import-Module-With-Measure Terminal-Icons
Import-Module-With-Measure DockerCompletion
if ($host.Name -eq 'ConsoleHost') {
    # https://github.com/PowerShell/PSReadLine#install-from-powershellgallery-preferred
    Import-Module-With-Measure PSReadLine
    Set-PSReadLineKeyHandler -Key Tab -Function Complete
    Set-PSReadLineOption -HistoryNoDuplicates -EditMode Windows
    Set-PSReadLineOption -PredictionSource History
    # Set-PSReadLineOption -PredictionViewStyle ListView
    Set-PSReadLineOption -PredictionViewStyle InlineView
    Set-PSReadLineOption -ShowToolTips
    Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
    Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
    Set-PSReadLineKeyHandler -Chord "Ctrl+RightArrow" -Function ForwardWord
}


oh-my-posh init pwsh | Invoke-Expression
oh-my-posh init pwsh --config "$workDir\DenebLab\devbox\windows\windows-terminal\paradox.omp.json" | Invoke-Expression

function OpenPSProfileFile { code $Home\Documents\PowerShell\Profile.ps1 }
function DockerKillContainerFn ([string]$ContainerName) {
    #Write-Host $ContainerName
    $output = docker.exe ps --filter name=$ContainerName --quiet | Format-List -Property "CONTAINER ID" | out-string
    $conteinerId = $output.Trim()
    if ([string]::IsNullOrEmpty($conteinerId)) {
        Write-Host "Cannot find container with name '$ContainerName'"
    }
    else {
        docker kill $conteinerId
    }
   
}

function ssh-copy-id([string]$userAtMachine){   
    $publicKey = "$ENV:USERPROFILE" + "/.ssh/id_rsa.pub"
    $publicKeySrc = Get-Content -Path $publicKey
    Write-Host "ssh-copy-id; Dst: $userAtMachine; "
    Write-Host "ssh-copy-id; PublickeyFile: $publicKey"
    Write-Host "ssh-copy-id; PublickeySrc: $publicKeySrc"
    if (!(Test-Path "$publicKey")){
        Write-Error "ERROR: failed to open ID file '$publicKey': No such file"            
    }
    else {
        & cat "$publicKey" | ssh $userAtMachine "umask 077; test -d .ssh || mkdir .ssh ; cat >> .ssh/authorized_keys || exit 1"      
        Write-Host "ssh-copy-id; Done"
    }
}

function ssh-copy-id-file([string]$userAtMachine, [string]$file ){   
    $publicKey = $file
    $publicKeySrc = Get-Content -Path $publicKey
    Write-Host "ssh-copy-id-file; Dst: $userAtMachine; "
    Write-Host "ssh-copy-id-file; PublickeyFile: $publicKey"
    Write-Host "ssh-copy-id-file; PublickeySrc: $publicKeySrc"
    if (!(Test-Path "$publicKey")){
        Write-Error "ERROR: failed to open ID file '$publicKey': No such file"            
    }
    else {
        & cat "$publicKey" | ssh $userAtMachine "umask 077; test -d .ssh || mkdir .ssh ; cat >> .ssh/authorized_keys || exit 1"      
        Write-Host "ssh-copy-id-file; Done"
    }
}

## Aliases

Set-Alias psProfile OpenPSProfileFile -Option ReadOnly
Set-Alias dkKillContainer DockerKillContainerFn -Option ReadOnly