# file: C:\Users\piotr\Documents\PowerShell\profile.ps1
# 
# 
# helper


$aapMiscHome = [IO.Path]::Combine($env:LOCALAPPDATA, "AntiPiracy", 'misc')
$themeFile =  [IO.Path]::Combine($aapMiscHome, "paradox.omp.json")


if ($host.Name -eq 'ConsoleHost') {
    # https://github.com/PowerShell/PSReadLine#install-from-powershellgallery-preferred
    Import-Module PSReadLine
    Set-PSReadLineKeyHandler -Key Tab -Function Complete
    Set-PSReadLineOption -HistoryNoDuplicates -EditMode Windows
    Set-PSReadLineOption -PredictionSource History
    #Set-PSReadLineOption -PredictionViewStyle ListView
    Set-PSReadLineOption -PredictionViewStyle InlineView
    Set-PSReadLineOption -ShowToolTips
    Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
    Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
    Set-PSReadLineKeyHandler -Chord "Ctrl+RightArrow" -Function ForwardWord
}


# Add oh-my-posh and Paradox theme
# INSTALL: winget install JanDeDobbeleer.OhMyPosh -s winget
# UPGRADE: winget upgrade JanDeDobbeleer.OhMyPosh -s winget
oh-my-posh init pwsh | Invoke-Expression
oh-my-posh init pwsh --config $themeFile  | Invoke-Expression

function OpenPSProfileFile { code $Home\Documents\PowerShell\Profile.ps1 }


## Aliases

Set-Alias psProfile OpenPSProfileFile -Option ReadOnly
Set-Alias dkKillContainer DockerKillContainerFn -Option ReadOnly
