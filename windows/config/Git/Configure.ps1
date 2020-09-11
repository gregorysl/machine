Function Assert-GitInstalled() {
    $GitVersion = git --version
    $IsInstalled = $null -ne $GitVersion -and $GitVersion -ne ""
    if (!$IsInstalled) {
        Throw "Git have not been installed."
    }
}

Assert-GitInstalled

$GitConfigSource = Join-Path $PSScriptRoot ".gitconfig"
$GitConfig = Join-Path $env:USERPROFILE ".gitconfig"

if (Test-Path $GitConfig -PathType Leaf) {
    Remove-Item -Path $GitConfig | Out-Null
}

Write-Host "Creating symlink to Git config..."
New-Item -Path $GitConfig -ItemType SymbolicLink -Value $GitConfigSource | Out-Null