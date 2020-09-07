Function Find-Files([string]$Pattern) {
    if ($null -ne $Pattern -and $Pattern -ne "") {
        Get-Childitem -Include $Pattern -File -Recurse -ErrorAction SilentlyContinue `
        | ForEach-Object { Resolve-Path -Relative $_ | Write-Host }
    }
}

Function Find-Directories([string]$Pattern) {
    if ($null -ne $Pattern -and $Pattern -ne "") {
        Get-Childitem -Include $Pattern -Directory -Recurse -ErrorAction SilentlyContinue `
        | ForEach-Object { Resolve-Path -Relative $_ | Write-Host }
    }
}

Function Clear-Docker() {
    & docker ps -a -q | ForEach-Object { docker rm $_ }
    & docker images -q | ForEach-Object { docker rmi $_ }
    & docker system prune --all --force
}

# Copies the current location to the clipboard
Function Copy-CurrentLocation() {
    $Result = (Get-Location).Path | clip.exe
    Write-Host "Copied current location to clipboard."
    return $Result
}

# Creates a new directory and enters it
Function New-Directory([string]$Name) {
    $Directory = New-Item -Path $Name -ItemType Directory
    if (Test-Path $Directory) {
        Set-Location $Name
    }
}

# Source location shortcuts
Function Enter-SourcesRootLocation { Enter-SourceLocation -Provider "root" -Path $Global:RootSourceLocation }
Function Enter-GitHubLocation { Enter-SourceLocation -Provider "github" -Path $Global:GitHubSourceLocation }
Function Enter-AzureDevOpsLocation { Enter-SourceLocation -Provider "azdo" -Path $Global:AzureDevOpsSourceLocation }
Function Enter-BitBucketLocation { Enter-SourceLocation -Provider "bitbucket" -Path $Global:BitBucketSourceLocation }
Function Enter-GitLabLocation { Enter-SourceLocation -Provider "gitlab" -Path $Global:GitLabSourceLocation }
Function Enter-SourceLocation([string]$Provider, [string]$Path) {
    if ([string]::IsNullOrWhiteSpace($Path)) {
        Write-Host "The source location for $Provider have not been set."
        return
    }
    Set-Location $Path
}

# Set window title
Function Set-WindowTitle([string]$Title) {
    $host.ui.RawUI.WindowTitle = $Title
}

# Aliases
Set-Alias ccl Copy-CurrentLocation
Set-Alias g2s Enter-SourcesRootLocation
Set-Alias g2gh Enter-GitHubLocation
Set-Alias g2azdo Enter-AzureDevOpsLocation
Set-Alias g2bb Enter-BitBucketLocation
Set-Alias g2gl Enter-GitLabLocation
Set-Alias sw Set-WindowTitle
Set-Alias ff Find-Files
Set-Alias fd Find-Directories
Set-Alias sudo gsudo
