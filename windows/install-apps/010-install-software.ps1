# Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Unrestricted

function InstallPackage($pack) {
   
    Write-host "Process: '$pack'"

    $r1 = cmd /c winget list -e --id $pack | Out-String
    if ($r1.ToLower().Contains("no installed package found matching input criteria") -eq $false  ) { 
        Write-host "Package '$pack' is installed"
        return;
    } 

    $r1 = cmd /c winget search -e --id $pack | Out-String
    if ($r1.ToLower().Contains("no package found matching input criteria")) { 
        Write-host "Can't find package '$pack'"
        return;
    } 

   
    

    $r1 = cmd /c winget install --accept-package-agreements --accept-source-agreements -e --id $pack | Out-String
    if ($r1.ToLower().Contains("successfully installed")) { 
        Write-host "Package '$pack' was installed successfully"
    } else {
        Write-host "Package '$pack' was NOT installed successfully"
    }    
}

####### BEGIN
# InstallPackage "SMPlayer.SMPlayer" - not working

InstallPackage "Bitwarden.Bitwarden"
InstallPackage "Ghisler.TotalCommander"
InstallPackage "Microsoft.DotNet.SDK.6"
InstallPackage "Microsoft.DotNet.SDK.8"
InstallPackage "Microsoft.DotNet.SDK.9"
InstallPackage "Microsoft.PowerShell"
InstallPackage "JanDeDobbeleer.OhMyPosh"
InstallPackage "Microsoft.WindowsTerminal"
InstallPackage "Microsoft.VisualStudioCode"
InstallPackage "Google.Chrome"
InstallPackage "IrfanSkiljan.IrfanView"
InstallPackage "Atlassian.Sourcetree"
InstallPackage "ES-Computing.EditPlus"
InstallPackage "Microsoft.Azure.StorageExplorer"
InstallPackage "7zip.7zip"
InstallPackage "Microsoft.AzureCLI"
InstallPackage "OpenJS.NodeJS"
InstallPackage "Bitwarden.CLI"
InstallPackage "Git.Git"
InstallPackage "Mozilla.Firefox"
InstallPackage "tailscale.tailscale"
InstallPackage "jqlang.jq"
InstallPackage "Google.Drive"
InstallPackage "Brave.Brave"
InstallPackage "Task.Task"
InstallPackage "Helm.Helm"

Install-Module PSReadLine -AllowPrerelease -Force

# use this one - works better, for  dotnet-script
(new-object Net.WebClient).DownloadString("https://raw.githubusercontent.com/dotnet-script/dotnet-script/master/install/install.ps1") | Invoke-Expression
# dotnet tool install -g dotnet-script
npm install -g @azure/static-web-apps-cli

Write-host "Done"