$ProgressPreference = 'SilentlyContinue'

function Install-Font() 
{
  param(
    [Parameter(Mandatory=$true)]
    [string] $FontPath
  )

  $shell = New-Object -ComObject Shell.Application
  $fonts = $shell.NameSpace(0x14)

  $fullPath = (Resolve-Path -Path $FontPath).Path
  $fonts.CopyHere($fullPath)
}

# Force TLS 1.2
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12

Expand-Archive .\NerdFont.zip -DestinationPath .\tmp\

Install-Font .\tmp\DejaVuSans.ttf
Install-Font .\tmp\ConsolasNF.ttf
Remove-Item .\tmp\ -Force -Recurse

# Set Ubuntu WSL colors to solarized dark
#reg import .\solarized_dark.reg
