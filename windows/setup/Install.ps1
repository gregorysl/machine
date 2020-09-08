[CmdletBinding(DefaultParameterSetName='Prereqs')]
Param(
    [Parameter(ParameterSetName='Prereqs')]
    [switch]$Prereqs,
    [Parameter(ParameterSetName='Prereqs')]
    [switch]$Docker,
    [Parameter(ParameterSetName='Software')]
    [switch]$Apps
)

# Nothing selected? Show help screen.
if (!$Prereqs.IsPresent -and !$Docker.IsPresent -and !$Apps.IsPresent) {
    Get-Help .\Install.ps1
    Exit
}

# Load some utilities
. (Join-Path $PSScriptRoot "../utilities/Utilities.ps1")

# Assert that we're running as administrators
Assert-Administrator -FailMessage "This script must be run as administrator."

# Install BoxStarter + Chocolatey if missing
if (!(Assert-CommandExists -CommandName "Install-BoxstarterPackage")) {
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://boxstarter.org/bootstrapper.ps1'))
    Get-Boxstarter -Force
}

if ($Prereqs.IsPresent) {
    Install-BoxstarterPackage (Join-Path $PSScriptRoot "Steps/Prereqs.ps1")
    RefreshEnv
}
if ($Apps.IsPresent) {
    Install-BoxstarterPackage (Join-Path $PSScriptRoot "Steps/Apps.ps1")
    RefreshEnv
}
if ($Docker.IsPresent) {
    Install-BoxstarterPackage (Join-Path $PSScriptRoot "Steps/Docker.ps1")
    RefreshEnv
}