Run Powershell - admin mode



Steps:
- do not use onedrive https://serverfault.com/questions/195397/change-the-powershell-profile-directory

Valid paths `$profile | select *`
```text
AllUsersAllHosts       : C:\Program Files\PowerShell\7\profile.ps1
AllUsersCurrentHost    : C:\Program Files\PowerShell\7\Microsoft.PowerShell_profile.ps1
CurrentUserAllHosts    : C:\Users\piotr\Documents\PowerShell\profile.ps1
CurrentUserCurrentHost : C:\Users\piotr\Documents\PowerShell\Microsoft.PowerShell_profile.ps1
```
- create drives `!work`, `!others`
- map drives `map-drive`
- update appd on  `Microsoft Store`
- install `winget` from  `Microsoft Store. Install:  "App Installer"
- install git `winget install --id Git.Git -e --source winget`
- install git `winget install -e --id Ghisler.TotalCommander`
- install git `winget install -e --id Microsoft.PowerShell`
- clone https://github.com/pkudrel/devbox to `!work\DenebLab\devbox`
- clone https://github.com/pkudrel/devbox-private to `!work\DenebLab\devbox-private`
- run `007-update-powershell.ps1`
- run `008-install.runonce.ps1`
- copy `!work\DenebLab\devbox\windows\powershell\profile.ps1` to `$HOME\Documents\PowerShell\profile.ps1`
- `010-install-software.ps1`
- `oh-my-posh font install` - `Meslo LGM NF` - https://ohmyposh.dev/docs/installation/fonts
- `030-install-clean.ps1` - clening
- windows 11: install `OneNote for windows 10` -  https://apps.microsoft.com/store/detail/onenote/9WZDNCRFHVJL

