Function Assert-DockerInstalled() {
    $DockerVersion = docker --version
    $IsInstalled = $null -ne $DockerVersion -and $DockerVersion -ne ""
    if (!$IsInstalled) {
        Throw "Docker have not been installed."
    }
}

Function Merge-JsonObjects {
    [CmdletBinding()]
    param (
        [Object] $Config1,
        [Object] $Config2
    )
    $Object = [ordered] @{}
    foreach ($Property in $Config1.PSObject.Properties) {
        $Object += @{$Property.Name = $Property.Value}

    }
    foreach ($Property in $Config2.PSObject.Properties) {
        if ($null -ne $Object.PSObject.Properties.Match($Property.Name)) {
            $Object[$Property.Name] = $Property.Value
        }
        else {
            $Object += @{$Property.Name = $Property.Value}
        }
    }
    return [pscustomobject] $Object
}

Assert-DockerInstalled

$DockerConfigSource = Join-Path $PSScriptRoot "settings.json.override"
$DockerConfig = Join-Path $env:USERPROFILE "AppData/Roaming/Docker/settings.json"
$Source = Get-Content -Path $DockerConfigSource -Raw | ConvertFrom-Json
$Target = Get-Content -Path $DockerConfig -Raw | ConvertFrom-Json
Write-Host "Updating Docker config..."
Merge-JsonObjects -Config1 $Target -Config2 $Source | ConvertTo-Json | Out-File -FilePath $DockerConfig

$WslConfigSource = Join-Path $PSScriptRoot ".wslconfig"
$WslConfig = Join-Path $env:USERPROFILE ".wslconfig"

if (-not (Test-Path $WslConfig)) {
    New-Item -Path $WslConfig -ItemType File | Out-Null
}

if ((Get-FileHash -Path $WslConfigSource -Algorithm SHA256).Hash -ne (Get-FileHash -Path $WslConfig -Algorithm SHA256).Hash) {
    Write-Host "Updating WSL config..."
    Remove-Item -Path $WslConfig
    Copy-Item -Path $WslConfigSource -Destination $WslConfig
    wsl --shutdown
}

Restart-Service *docker*