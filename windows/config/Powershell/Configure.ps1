$Script:RootSourceLocation = if(-not [String]::IsNullOrEmpty($Global:RootSourceLocation)) { $Global:RootSourceLocation } else { Join-Path $env:USERPROFILE "sources" }
$Script:GitHubSourceLocation = if(-not [String]::IsNullOrEmpty($Global:GitHubSourceLocation)) { $Global:GitHubSourceLocation } else { Join-Path $Script:RootSourceLocation "github" }
$Script:AzureDevOpsSourceLocation = if(-not [String]::IsNullOrEmpty($Global:AzureDevOpsSourceLocation)) { $Global:AzureDevOpsSourceLocation } else { Join-Path $Script:RootSourceLocation "azdo" }
$Script:BitBucketSourceLocation = if(-not [String]::IsNullOrEmpty($Global:BitBucketSourceLocation)) { $Global:BitBucketSourceLocation } else { Join-Path $Script:RootSourceLocation "bitbucket" }
$Script:GitLabSourceLocation = if(-not [String]::IsNullOrEmpty($Global:GitLabSourceLocation)) { $Global:GitLabSourceLocation } else { Join-Path $Script:RootSourceLocation "gitlab" }

Function New-SourcesDirectory([string]$Path) {
    if (Test-Path -Path $Path -Type Container) {
        return $Path
    }
    New-Item -Path $Path -ItemType Directory -Force
}

Function Update-TokenInFile([string] $Path, [string]$Token, [string]$Value) {
    (Get-Content -path $Path -Raw) `
        -Replace $Token, $Value `
    | Set-Content -Path $Path
}

New-SourcesDirectory -Path $Script:RootSourceLocation | Out-Null
New-SourcesDirectory -Path $Script:GitHubSourceLocation | Out-Null
New-SourcesDirectory -Path $Script:AzureDevOpsSourceLocation | Out-Null
New-SourcesDirectory -Path $Script:BitBucketSourceLocation | Out-Null
New-SourcesDirectory -Path $Script:GitLabSourceLocation | Out-Null

Write-Host "Adding PowerShell profile..."
if (-not (Test-Path -Path $PROFILE)) {
    New-Item -Path $PROFILE -ItemType File | Out-Null
}
$PowerShellProfileTemplatePath = Join-Path $PSScriptRoot "Profile.template"
$PowerShellProfilePath = (Join-Path $PSScriptRoot "Roaming.ps1")
$PowerShellPromptPath = (Join-Path $PSScriptRoot "Prompt.ps1")
$PowerShellLocalProfilePath = Join-Path (Get-Item $PROFILE).Directory.FullName "LocalProfile.ps1"
Copy-Item -Path $PowerShellProfileTemplatePath -Destination $PROFILE

$Tokens = [hashtable]@{
    '<<PROFILE>>'=$PowerShellProfilePath
    '<<PROMPT>>'=$PowerShellPromptPath
    '<<LOCALPROFILE>>'=$PowerShellLocalProfilePath
    '<<SRCROOTLOCATION>>'=$Script:RootSourceLocation
    '<<GITHUBLOCATION>>'=$Script:GitHubSourceLocation
    '<<AZURELOCATION>>'=$Script:AzureDevOpsSourceLocation
    '<<BITBUCKETLOCATION>>'=$Script:BitBucketSourceLocation
    '<<GITLABLOCATION>>'=$Script:GitLabSourceLocation
}

foreach ($Key in $Tokens.Keys) {
    Update-TokenInFile -Path $PROFILE -Token $Key -Value $Tokens[$Key]
}