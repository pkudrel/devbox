# helper
function Update-Module-With-Measure {  
    param ($ModuleName)
    $import = Measure-Command {
        Update-Module $ModuleName
    }
    Write-Host "$ModuleName update $($import.TotalMilliseconds) ms"
}


Write-Host "Begin update modules"
Update-Module-With-Measure oh-my-posh
Update-Module-With-Measure Terminal-Icons
Update-Module-With-Measure DockerCompletion
Update-Module-With-Measure PSReadLine

