[CmdletBinding(DefaultParameterSetName='Granular')]
Param(
    [Parameter(ParameterSetName='All')]
    [switch]$All,
    [Parameter(ParameterSetName='Granular')]
    [switch]$PowerShellProfile,
    [Parameter(ParameterSetName='Granular')]
    [switch]$Fonts,
    [Parameter(ParameterSetName='Granular')]
    [switch]$WindowsTerminalProfile,
    [Parameter(ParameterSetName='Granular')]
    [switch]$StarshipProfile,
    [Parameter(ParameterSetName='Granular')]
    [switch]$Docker,
    [Parameter(ParameterSetName='Granular')]
    [switch]$VSCode,
    [Parameter(ParameterSetName='Granular')]
    [switch]$Wox,
    [Parameter(ParameterSetName='Granular')]
    [switch]$Git
)

. (Join-Path $PSScriptRoot "../utilities/Utilities.ps1")

# Nothing selected? Show help screen.
if (!$PowerShellProfile.IsPresent -and !$Fonts.IsPresent -and !$WindowsTerminalProfile.IsPresent `
    -and !$StarshipProfile.IsPresent -and !$Docker.IsPresent -and !$VSCode.IsPresent `
    -and !$Wox.IsPresent -and !$Git.IsPresent -and !$All.IsPresent)
{
    Get-Help (Join-Path $PSScriptRoot "Install.ps1")
    Exit
}

#################################################################
# FONTS
#################################################################

if($All.IsPresent -or $Fonts.IsPresent) {
    . (Join-Path $PSScriptRoot "Fonts/Install.ps1")
}

#################################################################
# POWERSHELL
#################################################################

if($All.IsPresent -or $PowerShellProfile.IsPresent) {
    . (Join-Path $PSScriptRoot "Powershell/Configure.ps1")
}

#################################################################
# WINDOWS TERMINAL
#################################################################

if($All.IsPresent -or $WindowsTerminalProfile.IsPresent) {
    Assert-Administrator -FailMessage "Installing Windows Terminal profile requires administrator privilegies."
    . (Join-Path $PSScriptRoot "WindowsTerminal/Configure.ps1")
}

#################################################################
# STARSHIP
#################################################################

if($All.IsPresent -or $StarshipProfile.IsPresent) {
    Assert-Administrator -FailMessage "Installing Starship profile requires administrator privilegies."
    . (Join-Path $PSScriptRoot "Starship/Configure.ps1")
}

#################################################################
# DOCKER
#################################################################

if($All.IsPresent -or $Docker.IsPresent) {
    Assert-Administrator -FailMessage "Configuring Docker settings requires administrator privilegies."
    . (Join-Path $PSScriptRoot "Docker/Configure.ps1")
}

#################################################################
# VSCODE
#################################################################

if($All.IsPresent -or $VSCode.IsPresent) {
    Assert-Administrator -FailMessage "Installing VsCode settings requires administrator privilegies."
    . (Join-Path $PSScriptRoot "VSCode/Configure.ps1")
}

#################################################################
# WOX
#################################################################

if($All.IsPresent -or $Wox.IsPresent) {
    Assert-Administrator -FailMessage "Installing Wox settings requires administrator privilegies."
    . (Join-Path $PSScriptRoot "Wox/Configure.ps1")
}

#################################################################
# Git
#################################################################
if($All.IsPresent -or $Git.IsPresent) {
    Assert-Administrator -FailMessage "Installing Git config requires administrator privilegies."
    . (Join-Path $PSScriptRoot "Git/Configure.ps1")
}