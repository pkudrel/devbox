$workDir = "$env:USERPROFILE\!work"
$profileFile = "$workDir\DenebLab\devbox\windows\powershell\profile.default.ps1"
Write-Host "Profile file: $profileFile"
Import-Module $profileFile