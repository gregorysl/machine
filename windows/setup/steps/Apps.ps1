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
choco upgrade --cache="$ChocoCachePath" --yes starship
choco upgrade --cache="$ChocoCachePath" --yes azure-cli


# ------------------------------------------------------------------------
# Communication
# ------------------------------------------------------------------------

choco upgrade --cache="$ChocoCachePath" --yes microsoft-teams.install
choco upgrade --cache="$ChocoCachePath" --yes slack
choco upgrade --cache="$ChocoCachePath" --yes zoom

# ------------------------------------------------------------------------
# Multimedia
# ------------------------------------------------------------------------

choco upgrade --cache="$ChocoCachePath" --yes googlechrome
choco upgrade --cache="$ChocoCachePath" --yes microsoft-edge
choco upgrade --cache="$ChocoCachePath" --yes office365business -params '"/productid:O365ProPlusRetail /exclude:""Access Groove Lync OneDrive OneNote Outlook Publisher Teams"""'

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
choco upgrade --cache="$ChocoCachePath" --yes cmake.portable
choco upgrade --cache="$ChocoCachePath" --yes chocolateygui --params "/ShowConsoleOutput=$true /UseDelayedSearch=$false /OutdatedPackagesCacheDurationInMinutes=120 /DefaultToTileViewForLocalSource"
choco upgrade --cache="$ChocoCachePath" --yes gsudo
choco upgrade --cache="$ChocoCachePath" --yes k9s
choco upgrade --cache="$ChocoCachePath" --yes keepassxc
choco upgrade --cache="$ChocoCachePath" --yes multicommander
choco upgrade --cache="$ChocoCachePath" --yes nugetpackageexplorer
choco upgrade --cache="$ChocoCachePath" --yes paint.net
choco upgrade --cache="$ChocoCachePath" --yes sysinternals
choco upgrade --cache="$ChocoCachePath" --yes winscp.portable

# ------------------------------------------------------------------------
# Editor tools
# ------------------------------------------------------------------------

choco upgrade --cache="$ChocoCachePath" --yes azure-data-studio
choco upgrade --cache="$ChocoCachePath" --yes notepadplusplus.install
choco upgrade --cache="$ChocoCachePath" --yes postman
choco upgrade --cache="$ChocoCachePath" --yes vscode --params "/NoDesktopIcon"
choco upgrade --cache="$ChocoCachePath" --yes visualstudio2019professional --package-parameters "--add Microsoft.VisualStudio.Workload.NetCoreTools --includeRecommended --norestart --passive --locale en-US"

# ------------------------------------------------------------------------
# Hobby and fun
# ------------------------------------------------------------------------

choco upgrade --cache="$ChocoCachePath" --yes geforce-experience
choco upgrade --cache="$ChocoCachePath" --yes geforce-experience-disable-updates-winconfig
choco upgrade --cache="$ChocoCachePath" --yes obs-studio
choco upgrade --cache="$ChocoCachePath" --yes obs-virtualcam
choco upgrade --cache="$ChocoCachePath" --yes origin
choco upgrade --cache="$ChocoCachePath" --yes steam
choco upgrade --cache="$ChocoCachePath" --yes tidal
choco upgrade --cache="$ChocoCachePath" --yes vlc --params "/Language:en"

##########################################################################
# Install VSCode extensions
##########################################################################

# ------------------------------------------------------------------------
# Common
# ------------------------------------------------------------------------

code --install-extension ms-vscode-remote.remote-wsl
code --install-extension k--kato.intellij-idea-keybindings
code --install-extension vscodevim.vim
code --install-extension EditorConfig.EditorConfig
code --install-extension DavidAnson.vscode-markdownlint
code --install-extension yzhang.markdown-all-in-one
code --install-extension ban.spellright

# ------------------------------------------------------------------------
# Syntax/Language support
# ------------------------------------------------------------------------

code --install-extension DotJoshJohnson.xml
code --install-extension eriklynd.json-tools
code --install-extension be5invis.toml
code --install-extension ms-dotnettools.csharp
code --install-extension ms-vscode.powershell

# ------------------------------------------------------------------------
# Tools
# ------------------------------------------------------------------------
code --install-extension adamhartford.vscode-base64

# ------------------------------------------------------------------------
# GUI
# ------------------------------------------------------------------------
code --install-extension monokai.theme-monokai-pro-vscode

# ------------------------------------------------------------------------
# Build tools/systems
# ------------------------------------------------------------------------
code --install-extension cake-build.cake-vscode

# ------------------------------------------------------------------------
# Docker/Kubernetes
# ------------------------------------------------------------------------
code --install-extension ms-azuretools.vscode-docker
code --install-extension exiasr.hadolint
code --install-extension mikestead.dotenv
code --install-extension redhat.vscode-yaml
code --install-extension ms-kubernetes-tools.vscode-kubernetes-tools

##########################################################################
# Install Powershell Modules
##########################################################################

PowerShellGet\Install-Module posh-git -Scope CurrentUser -Force
PowerShellGet\Install-Module posh-docker -Scope CurrentUser -Force

##########################################################################
# Restore Temporary Settings
##########################################################################

Enable-UAC
Enable-MicrosoftUpdate