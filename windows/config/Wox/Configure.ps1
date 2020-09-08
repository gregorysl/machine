$WoxExecutable = "$env:LOCALAPPDATA\Wox\Wox.exe"

Function Assert-WoxInstalled() {
    if (-not (Get-Item -Path $WoxExecutable -ErrorAction 'SilentlyContinue')) {
        Throw "Wox have not been installed."
    }
}

Assert-WoxInstalled

$IsRunning = $false
$WoxProcess = Get-Process -Name Wox -ErrorAction 'SilentlyContinue'

if ($Wox) {
    $IsRunning = $true
    $WoxProcess | Stop-Process
    $WoxProcess | Wait-Process
}

$WoxConfigSource = Join-Path $PSScriptRoot "settings.json"
$WoxConfig = Join-Path $env:APPDATA "Wox/Settings/Settings.json"

if(Test-Path $WoxConfig -Type Leaf) {
    Remove-Item -Path $WoxConfig
}

Write-Host "Creating symlink to Wox settings..."
New-Item -Path $WoxConfig -ItemType SymbolicLink -Value $WoxConfigSource | Out-Null

if ($IsRunning) {
    Start-Process -FilePath $WoxExecutable
}