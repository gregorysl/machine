$ErrorActionPreference = 'Stop'

$softwareName = 'SemanticMerge'
$version      = '2.0.152.0'
$url          = 'https://users.semanticmerge.com/Download/DownloadInstaller?platform=Windows'

if (!$Env:ChocolateyForce -and $version -eq (Get-UninstallRegistryKey $softwareName).DisplayVersion) {
    Write-Host "Version $version is already installed."
    return
}

$packageArgs = @{
    packageName    = 'semanticmerge.install'
    softwareName   = $softwareName
    checksum       = 'A764F34E9747A33437594F726A1C0B9205C9D0E968B78274AF9ACED897F8C81B'
    checksumType   = 'sha256'
    url            = $url
    fileType       = 'exe'
    silentArgs     = '--unattendedmodeui none', '--mode unattended', "--user $env:USERNAME"
    validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs

$uninstallKey = Get-UninstallRegistryKey $softwareName

if ($uninstallKey -and $null -eq $uninstallKey.QuietUninstallString) {
    New-ItemProperty -Path $uninstallKey.PSPath `
        -Name 'QuietUninstallString' `
        -Value "$($uninstallKey.UninstallString) --mode unattended" `
        -Force | Out-Null

}