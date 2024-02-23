# https://github.com/microsoft/terminal/releases/download/v1.19.10302.0/Microsoft.WindowsTerminal_1.19.10302.0_8wekyb3d8bbwe.msixbundle
#Invoke-WebRequest -Uri https://github.com/microsoft/terminal/releases/download/v1.19.10302.0/Microsoft.WindowsTerminal_1.19.10302.0_8wekyb3d8bbwe.msixbundle -OutFile Microsoft.WindowsTerminal_1.19.10302.0_8wekyb3d8bbwe.msixbundle
Invoke-WebRequest -Uri https://github.com/PowerShell/PowerShell/releases/download/v7.4.1/PowerShell-7.4.1-win-x64.msi -OutFile PowerShell-7.4.1-win-x64.msi


Add-AppxPackage Microsoft.WindowsTerminal_1.19.10302.0_8wekyb3d8bbwe.msixbundle


#winget install --accept-source-agreements --accept-package-agreements -e --id Microsoft.WindowsTerminal 
#winget install --accept-source-agreements --accept-package-agreements -e --id Microsoft.PowerShell