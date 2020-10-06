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
# Install applications
##########################################################################

# ------------------------------------------------------------------------
# Source control
# ------------------------------------------------------------------------

choco upgrade --cache="$ChocoCachePath" --yes git.install --params "/GitOnlyOnPath /NoAutoCrlf /SChannel /NoShellIntegration"
choco upgrade --cache="$ChocoCachePath" --yes git-fork

# ------------------------------------------------------------------------
# Terminal + CLI
# ------------------------------------------------------------------------

choco upgrade --cache="$ChocoCachePath" --yes microsoft-windows-terminal
choco upgrade --cache="$ChocoCachePath" --yes azure-cli
choco upgrade --cache="$ChocoCachePath" --yes awscli

# ------------------------------------------------------------------------
# Communication
# ------------------------------------------------------------------------

choco upgrade --cache="$ChocoCachePath" --yes microsoft-teams.install

# ------------------------------------------------------------------------
# Multimedia
# ------------------------------------------------------------------------

choco upgrade --cache="$ChocoCachePath" --yes googlechrome
choco upgrade --cache="$ChocoCachePath" --yes microsoft-edge
choco upgrade --cache="$ChocoCachePath" --yes office365business -params '"/productid:O365ProPlusRetail /exclude:""Access Groove Lync OneDrive OneNote Publisher Teams"""'

# ------------------------------------------------------------------------
# Frameworks
# ------------------------------------------------------------------------

choco upgrade --cache="$ChocoCachePath" --yes nodejs-lts
choco upgrade --cache="$ChocoCachePath" --yes powershell-core --install-arguments='"ADD_EXPLORER_CONTEXT_MENU_OPENPOWERSHELL=1"'

# ------------------------------------------------------------------------
# Tools
# ------------------------------------------------------------------------

choco upgrade --cache="$ChocoCachePath" --yes 7zip.install
choco upgrade --cache="$ChocoCachePath" --yes curl
choco upgrade --cache="$ChocoCachePath" --yes gsudo
choco upgrade --cache="$ChocoCachePath" --yes displayfusion
choco upgrade --cache="$ChocoCachePath" --yes openvpn --params "'/SELECT_OPENVPN=1 /SELECT_OPENVPNGUI=1 /SELECT_TAP=1 /SELECT_EASYRSA=1 /SELECT_SERVICE=0 /SELECT_OPENSSL_UTILITIES=1 /SELECT_SHORTCUTS=0 /SELECT_ASSOCIATIONS=1 /SELECT_LAUNCH=1'"
choco upgrade --cache="$ChocoCachePath" --yes winscp.portable

# ------------------------------------------------------------------------
# Editor tools
# ------------------------------------------------------------------------

choco upgrade --cache="$ChocoCachePath" --yes azure-data-studio
choco upgrade --cache="$ChocoCachePath" --yes postman
choco upgrade --cache="$ChocoCachePath" --yes vscode --params "/NoDesktopIcon"
choco upgrade --cache="$ChocoCachePath" --yes visualstudio2019professional --package-parameters "--add Microsoft.VisualStudio.Workload.NetCoreTools --includeRecommended --norestart --passive --locale en-US"

# ------------------------------------------------------------------------
# Hobby and fun
# ------------------------------------------------------------------------

choco upgrade --cache="$ChocoCachePath" --yes geforce-experience
choco upgrade --cache="$ChocoCachePath" --yes geforce-experience-disable-updates-winconfig
choco upgrade --cache="$ChocoCachePath" --yes steam
choco upgrade --cache="$ChocoCachePath" --yes vlc --params "/Language:en"

##########################################################################
# Restore Temporary Settings
##########################################################################

Enable-UAC
Enable-MicrosoftUpdate