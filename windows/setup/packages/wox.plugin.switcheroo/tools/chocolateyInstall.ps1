$ErrorActionPreference = 'Stop'

$isRunning = $false
$woxProcess = Get-Process -Name Wox -ErrorAction 'SilentlyContinue'

if ($woxProcess) {
    $isRunning = $true
    $woxProcess | Stop-Process
    $woxProcess | Wait-Process
}

$toolsDir = Split-Path $MyInvocation.MyCommand.Definition

$packageArgs = @{
    packageName    = 'wox.plugin.switcheroo'
    checksum       = 'E5DB229E94AF88DD0BFB4A94CB3C9A1D301FCAA8DE340AB9619E6BF1A3F92D89'
    checksumType   = 'sha256'
    url            = 'http://api.wox.one/media/plugin/DB634BE6F3D34F6D9D64F7C2AEE3ECEC/Wox.Plugin.Switcheroo-c42acc05-befc-4687-94ac-9008bb33385c-7c0fcfa1-e731-4c69-b895-fcc63466c8d7.wox'
    unzipLocation  = "$env:APPDATA\Wox\Plugins\Switcheroo for Wox-a6a509aa-e430-4cef-8918-0052861e5f7e"
}

try {
    Install-ChocolateyZipPackage @packageArgs

    $pluginConfigDir = "$env:APPDATA\Wox\Settings\Plugins\Wox.Plugin.Switcheroo"

    if (-not (Test-Path -Path $pluginConfigDir -PathType Container)) {
        New-Item -Path $pluginConfigDir -ItemType Directory -Force
        Copy-Item -Path $toolsDir\SwitcherooSettings.jsonn `
            -Destination "$pluginConfigDir\SwitcherooSettings.json" `
            -ErrorAction 'SilentlyContinue'
    }
}
finally {
    if ($isRunning) {
        Start-Process -FilePath "$env:LOCALAPPDATA\Wox\Wox.exe"
    }
}