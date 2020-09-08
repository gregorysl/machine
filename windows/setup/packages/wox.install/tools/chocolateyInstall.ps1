$ErrorActionPreference = 'Stop'

$softwareName = 'Wox'
$version      = '1.4.1196'

if (!$Env:ChocolateyForce -and $version -eq (Get-UninstallRegistryKey $softwareName).DisplayVersion) {
    Write-Host "Version $version is already installed."
    return
}

$packageArgs = @{
    packageName    = 'wox.install'
    softwareName   = $softwareName
    checksum       = '2cd868e2f83b629952be6ff4c207608ae7da4a74fabe512b138fa72261f526c4'
    checksumType   = 'sha256'
    url            = 'https://github.com/Wox-launcher/Wox/releases/download/v1.4.1196/Wox-1.4.1196.exe'
    fileType       = 'exe'
    silentArgs     = '--silent'
    validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs