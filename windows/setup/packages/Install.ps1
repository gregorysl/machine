##########################################################################
# Create temporary directory
##########################################################################

# Workaround choco / boxstarter path too long error
# https://github.com/chocolatey/boxstarter/issues/241
$ChocoCachePath = "$env:USERPROFILE\AppData\Local\Temp\chocolatey"
New-Item -Path $ChocoCachePath -ItemType Directory -Force

##########################################################################
# Install applications
##########################################################################

# ------------------------------------------------------------------------
# LOCAL
# ------------------------------------------------------------------------
$localPackagesSource = "$PSScriptRoot\source"
New-Item -Path $localPackagesSource -ItemType Directory -Force
choco pack "$PSScriptRoot\wox.install\wox.install.nuspec" -f -out $localPackagesSource
choco pack "$PSScriptRoot\wox.plugin.switcheroo\wox.plugin.switcheroo.nuspec" -f -out $localPackagesSource

# Installing Wox and switcheroo plugin from local packages is required because:
# - Wox package from choco repository is installing Python and Everywhere dependency
# - There is no official way for installing wox plugins
choco upgrade --cache="$ChocoCachePath" --yes wox.install -s $localPackagesSource
choco upgrade --cache="$ChocoCachePath" --yes wox.plugin.switcheroo -s $localPackagesSource
