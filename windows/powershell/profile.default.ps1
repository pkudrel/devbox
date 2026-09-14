# file: C:\Users\piotr\Documents\PowerShell\profile.ps1

######
###### INSTALL
######

# Clone https://github.com/pkudrel/devbox to W:\DenebLab\devbox

# Oh My Posh
# INSTALL: winget install JanDeDobbeleer.OhMyPosh -s winget
# UPGRADE: winget upgrade JanDeDobbeleer.OhMyPosh -s winget

## posh-git
# Install-Module posh-git -Scope CurrentUser -Force

## Terminal-Icons
# Install-Module Terminal-Icons -Scope CurrentUser -Force

## DockerCompletion
# Install-Module DockerCompletion -Scope CurrentUser -Force


######
###### ENCODING
######

[Console]::InputEncoding =
[Console]::OutputEncoding =
    [System.Text.UTF8Encoding]::new()


######
###### GLOBALS
######

$workDir = "$env:USERPROFILE\!work"

$cacheDir =
    Join-Path $env:LOCALAPPDATA "PowerShell\Cache"

if (-not (Test-Path $cacheDir)) {
    New-Item `
        -Path $cacheDir `
        -ItemType Directory `
        -Force |
        Out-Null
}

$profileTimings =
    [System.Collections.Generic.List[string]]::new()


######
###### HELPERS
######

function Import-LatestModule-With-Measure {
    param (
        [Parameter(Mandatory)]
        [string] $Name
    )

    $module =
        Get-Module -ListAvailable $Name |
        Sort-Object Version -Descending |
        Select-Object -First 1

    if (-not $module) {
        throw "Module '$Name' not found."
    }

    $sw =
        [System.Diagnostics.Stopwatch]::StartNew()

    try {
        Import-Module `
            $module.Path `
            -ErrorAction Stop
    }
    finally {
        $sw.Stop()

        $profileTimings.Add(
            "$Name $([Math]::Round($sw.Elapsed.TotalMilliseconds)) ms"
        )
    }
}


######
###### MODULES
######

Import-LatestModule-With-Measure posh-git

$env:POSH_GIT_ENABLED = $true

Import-LatestModule-With-Measure Terminal-Icons

Import-LatestModule-With-Measure DockerCompletion


######
###### PSREADLINE
######

if ($host.Name -eq 'ConsoleHost') {

    # https://github.com/PowerShell/PSReadLine

    ## No profile:
    # pwsh -NoProfile

    ## Find installed versions:
    # Get-Module -ListAvailable PSReadLine

    ## INSTALL:
    # Install-Module PSReadLine -AllowPrerelease -Force

    ## UPGRADE:
    # Update-Module PSReadLine -AllowPrerelease -Force

    $sw =
        [System.Diagnostics.Stopwatch]::StartNew()

    Import-Module PSReadLine

    $sw.Stop()

    $profileTimings.Add(
        "PSReadLine $([Math]::Round($sw.Elapsed.TotalMilliseconds)) ms"
    )


    Set-PSReadLineKeyHandler `
        -Key Tab `
        -Function Complete


    Set-PSReadLineOption `
        -HistoryNoDuplicates `
        -EditMode Windows


    Set-PSReadLineOption `
        -PredictionSource History


    Set-PSReadLineOption `
        -PredictionViewStyle InlineView


    Set-PSReadLineOption `
        -ShowToolTips


    Set-PSReadLineKeyHandler `
        -Key UpArrow `
        -Function HistorySearchBackward


    Set-PSReadLineKeyHandler `
        -Key DownArrow `
        -Function HistorySearchForward


    Set-PSReadLineKeyHandler `
        -Chord "Ctrl+RightArrow" `
        -Function ForwardWord
}


######
###### OH MY POSH
######

$ompConfig =
    "$workDir\DenebLab\devbox\windows\windows-terminal\paradox.omp.json"

$ompCacheFile =
    Join-Path $cacheDir "oh-my-posh-init.ps1"


$ompCommand =
    Get-Command `
        oh-my-posh `
        -CommandType Application `
        -ErrorAction Stop


$refreshOmpCache =
    -not (Test-Path $ompCacheFile)


if (-not $refreshOmpCache) {

    $ompExe =
        Get-Item $ompCommand.Source

    $ompCache =
        Get-Item $ompCacheFile


    #
    # Rebuild cache after Oh My Posh upgrade.
    #

    if ($ompExe.LastWriteTimeUtc -gt $ompCache.LastWriteTimeUtc) {
        $refreshOmpCache = $true
    }


    #
    # Rebuild cache when config changes.
    #

    if (Test-Path $ompConfig) {

        $ompConfigItem =
            Get-Item $ompConfig

        if ($ompConfigItem.LastWriteTimeUtc -gt $ompCache.LastWriteTimeUtc) {
            $refreshOmpCache = $true
        }
    }
}


if ($refreshOmpCache) {

    & $ompCommand.Source `
        init pwsh `
        --config $ompConfig |
        Set-Content `
            -Path $ompCacheFile `
            -Encoding UTF8
}


$sw =
    [System.Diagnostics.Stopwatch]::StartNew()

. $ompCacheFile

$sw.Stop()

$profileTimings.Add(
    "oh-my-posh $([Math]::Round($sw.Elapsed.TotalMilliseconds)) ms"
)


######
###### FUNCTIONS
######

function OpenPSProfileFile {
    code "$Home\Documents\PowerShell\Profile.ps1"
}


function DockerKillContainerFn {

    param (
        [string] $ContainerName
    )

    $output =
        docker.exe ps `
            --filter "name=$ContainerName" `
            --quiet |
        Out-String

    $containerId =
        $output.Trim()

    if ([string]::IsNullOrEmpty($containerId)) {

        Write-Host `
            "Cannot find container with name '$ContainerName'"

        return
    }

    docker kill $containerId
}


######
###### TASK COMPLETION
######

# https://taskfile.dev/

$taskCompletionFile =
    Join-Path $cacheDir "task-completion.ps1"


$taskCommand =
    Get-Command `
        task `
        -CommandType Application `
        -ErrorAction SilentlyContinue


$sw =
    [System.Diagnostics.Stopwatch]::StartNew()


if ($taskCommand) {

    $refreshTaskCompletion =
        -not (Test-Path $taskCompletionFile)


    if (-not $refreshTaskCompletion) {

        $taskExe =
            Get-Item $taskCommand.Source

        $completionFile =
            Get-Item $taskCompletionFile


        #
        # Rebuild after Task update.
        #

        if ($taskExe.LastWriteTimeUtc -gt $completionFile.LastWriteTimeUtc) {
            $refreshTaskCompletion = $true
        }
    }


    if ($refreshTaskCompletion) {

        & $taskCommand.Source `
            --completion powershell |
            Set-Content `
                -Path $taskCompletionFile `
                -Encoding UTF8
    }


    . $taskCompletionFile
}


$sw.Stop()

$profileTimings.Add(
    "task $([Math]::Round($sw.Elapsed.TotalMilliseconds)) ms"
)


######
###### ALIASES
######

Set-Alias `
    psProfile `
    OpenPSProfileFile `
    -Option ReadOnly


Set-Alias `
    dkKillContainer `
    DockerKillContainerFn `
    -Option ReadOnly


Set-Alias `
    t `
    task

function winget-upgrade-all {
    winget upgrade --all --include-unknown --accept-source-agreements --accept-package-agreements @args
}


######
###### SBX RUNNER
######

# https://github.com/deneblab/sbx-templates

$sw =
    [System.Diagnostics.Stopwatch]::StartNew()

. "$PSScriptRoot\mods\sbx-runner.ps1"

$sw.Stop()

$profileTimings.Add(
    "sbx-runner $([Math]::Round($sw.Elapsed.TotalMilliseconds)) ms"
)


######
###### PROFILE TIMINGS
######

Write-Host "Profile: $($profileTimings -join ' | ')"