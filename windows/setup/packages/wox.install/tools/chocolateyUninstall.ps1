$ErrorActionPreference = 'Stop'

$softwareName = 'Wox'
# https://github.com/chocolatey/choco/issues/705
Start-Process -FilePath cmd.exe -ArgumentList '/c', (Get-UninstallRegistryKey $softwareName).QuietUninstallString -Wait