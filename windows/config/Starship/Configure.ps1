Function Assert-StarshipInstalled() {
    $StarshipVersion = starship --version
    $IsInstalled = $null -ne $StarshipVersion -and $StarshipVersion -ne ""
    if (!$IsInstalled) {
        Throw "Starship have not been installed."
    }
}

Assert-StarshipInstalled

# Create symlink to Starship profile
$StarshipSource = Join-Path $PSScriptRoot "starship.toml"
$StarshipConfigDirectory = Join-Path $env:USERPROFILE ".config"
$StarshipConfigDestination = Join-Path $StarshipConfigDirectory "starship.toml"
if(!(Test-Path $StarshipConfigDirectory)) {
    Write-Host "Creating ~/.config directory..."
    New-Item $StarshipConfigDirectory -ItemType Directory
}
if(Test-Path $StarshipConfigDestination) {
    Remove-Item -Path $StarshipConfigDestination
}
Write-Host "Creating symlink to Starship profile..."
New-Item -Path $StarshipConfigDestination -ItemType SymbolicLink -Value $StarshipSource | Out-Null