$workDir = "$env:USERPROFILE\!work"
$profileFile = "$workDir\DenebLab\devbox\windows\powershell\profile.default.ps1"
Write-Host "Profile: $profileFile"
Import-Module $profileFile