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
$workDir = "$PSScriptRoot\!work"

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
    ## No profile: powershell -noprofile
    ## Find all install versions: (Get-Module -ListAvailable PSReadLine*).path
    ## INSTALL Run form powershell core
    ## INSTALL: "C:\Program Files\PowerShell\7\pwsh.exe" -noprofile -command "Install-Module PSReadLine -AllowPrerelease -Force"
    ## UPGRADE: "C:\Program Files\PowerShell\7\pwsh.exe" -noprofile -command "Update-Module PSReadLine -AllowPrerelease -Force"
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

#oh-my-posh init pwsh | Invoke-Expression
oh-my-posh init pwsh --config "$workDir\DenebLab\devbox\windows\windows-terminal\paradox.omp.json" | Invoke-Expression

