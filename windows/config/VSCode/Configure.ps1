Function Assert-VSCodeInstalled() {
    $VSCodeVersion = code --version
    $IsInstalled = $null -ne $VSCodeVersion -and $VSCodeVersion -ne ""
    if (!$IsInstalled) {
        Throw "VSCode have not been installed."
    }
}

Assert-VsCodeInstalled

$VSCodeSource = Join-Path $PSScriptRoot "settings.json"
$VSCodeConfig = Join-Path $env:USERPROFILE "AppData/Roaming/Code/User/settings.json"
if(Test-Path $VSCodeConfig) {
    Remove-Item -Path $VSCodeConfig
}
Write-Host "Creating symlink to VSCode settings..."
New-Item -Path $VSCodeConfig -ItemType SymbolicLink -Value $VSCodeSource | Out-Null