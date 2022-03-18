# file: C:\Users\piotr\Documents\PowerShell\profile.ps1
# 
# 
# helper
function Import-Module-With-Measure {  
    param ($ModuleName)
    $import = Measure-Command {
        Import-Module $ModuleName
    }
    Write-Host "$ModuleName import $($import.TotalMilliseconds) ms"
}


Import-Module-With-Measure posh-git
$env:POSH_GIT_ENABLED = $true
Import-Module-With-Measure oh-my-posh
Import-Module-With-Measure Terminal-Icons
Import-Module-With-Measure DockerCompletion
if ($host.Name -eq 'ConsoleHost')
{
    Import-Module-With-Measure PSReadLine
    Set-PSReadLineKeyHandler -Key Tab -Function Complete
    Set-PSReadLineOption -HistoryNoDuplicates -EditMode Windows
    Set-PSReadLineOption -PredictionSource History
    #Set-PSReadLineOption -PredictionViewStyle ListView
    Set-PSReadLineOption -PredictionViewStyle InlineView
    Set-PSReadLineOption -ShowToolTips
}


#Set-Theme Paradox
#Set-PoshPrompt -Theme Paradox
Set-PoshPrompt -Theme W:\DenebLab\devbox\windows\windows-terminal\paradox.omp.json
