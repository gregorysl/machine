$Script:WindowsTerminalAppName = "Microsoft.WindowsTerminal_8wekyb3d8bbwe"

Function Get-WindowsStoreAppPath([string]$App) {
    $Packages = Join-Path $Env:LOCALAPPDATA "Packages"
    return Join-Path $Packages $App
}

Function Assert-WindowsTerminalInstalled() {
    if (!(Test-WindowsTerminal)) {
        Throw "Windows Terminal have not been installed."
    }
}

Function Test-WindowsTerminal() {
    $Path = Get-WindowsStoreAppPath -App "$Script:WindowsTerminalAppName/LocalState"
    return Test-Path -Path $Path -PathType Container
}

Assert-WindowsTerminalInstalled

# Create symlink to Windows Terminal settings
$TerminalProfileSource = Join-Path $PSScriptRoot "settings.json"
$TerminalPath = Get-WindowsStoreAppPath -App $Script:WindowsTerminalAppName
$TerminalProfileDestination = Join-Path $TerminalPath "LocalState/settings.json"
if(Test-Path $TerminalProfileDestination) {
    Remove-Item -Path $TerminalProfileDestination
}

Write-Host "Creating symlink to Windows terminal settings..."
New-Item -Path $TerminalProfileDestination -ItemType SymbolicLink -Value $TerminalProfileSource | Out-Null

Write-Host "Setting environment 'WINDOWSTERMINAL_IMAGES' variable..."
$ImagesPath = Join-Path $PSScriptRoot "Images"
[Environment]::SetEnvironmentVariable("WINDOWSTERMINAL_IMAGES", "$ImagesPath", "User")