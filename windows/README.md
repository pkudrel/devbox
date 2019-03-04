# Pre
- chocolatey https://chocolatey.org/install run as administrator (powershell)
```
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

choco feature enable -n allowGlobalConfirmation
```

- boxstarter https://boxstarter.org/
```
cinst Boxstarter
```
