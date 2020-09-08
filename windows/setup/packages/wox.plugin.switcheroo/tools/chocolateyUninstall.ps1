$ErrorActionPreference = 'Stop'

$isRunning = $false
$woxProcess = Get-Process -Name Wox -ErrorAction 'SilentlyContinue'

if ($woxProcess) {
    $isRunning = $true
    $woxProcess | Stop-Process
    $woxProcess | Wait-Process -ErrorAction 'SilentlyContinue'
    # Wait 5 seconds to ensure ManagedWinapi.dll is not blocked
    Start-Sleep -Seconds 5
}

try {
    if (Test-Path "$env:APPDATA\Wox\Plugins\Switcheroo for Wox-a6a509aa-e430-4cef-8918-0052861e5f7e") {
        Remove-Item -Recurse -Force "$env:APPDATA\Wox\Plugins\Switcheroo for Wox-a6a509aa-e430-4cef-8918-0052861e5f7e"
    }
    if (Test-Path "$env:APPDATA\Wox\Settings\Plugins\Wox.Plugin.Switcheroo") {
        Remove-Item -Recurse -Force "$env:APPDATA\Wox\Settings\Plugins\Wox.Plugin.Switcheroo"
    }
}
finally {
    if ($isRunning) {
        Start-Process -FilePath "$env:LOCALAPPDATA\Wox\Wox.exe"
    }
}