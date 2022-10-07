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
if ($host.Name -eq 'ConsoleHost') {
    # https://github.com/PowerShell/PSReadLine#install-from-powershellgallery-preferred
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

## Aliases

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

Set-Alias psprof OpenPSProfileFile -Option ReadOnly
Set-Alias dkKillContainer DockerKillContainerFn -Option ReadOnly
