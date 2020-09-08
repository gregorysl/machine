##########################################################################
# Disable UAC (temporarily)
##########################################################################

Disable-UAC

##########################################################################
# Create temporary directory
##########################################################################

# Workaround choco / boxstarter path too long error
# https://github.com/chocolatey/boxstarter/issues/241
$ChocoCachePath = "$env:USERPROFILE\AppData\Local\Temp\chocolatey"
New-Item -Path $ChocoCachePath -ItemType Directory -Force

##########################################################################
# Running in Windows Sandbox?
##########################################################################

if ($env:UserName -eq "WDAGUtilityAccount") {
    Write-Host "Sorry, can't install Ubuntu in a Windows Sandbox."
    Return
}

##########################################################################
# Install Ubuntu
##########################################################################

choco upgrade --cache="$ChocoCachePath" --yes wsl2
choco upgrade --cache="$ChocoCachePath" --yes wsl-ubuntu-2004
ubuntu2004.exe install --root
choco upgrade --cache="$ChocoCachePath" --yes docker-desktop --pre

# Install Ubuntu
RefreshEnv

# Update Ubuntu
wsl -d Ubuntu-20.04 -u root apt-get update -y
wsl -d Ubuntu-20.04 -u root apt-get upgrade -y

##########################################################################
# Restore Temporary Settings
##########################################################################

Enable-UAC
Enable-MicrosoftUpdate