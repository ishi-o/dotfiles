$ErrorActionPreference = "Stop"

if (-not (Get-Module -ListAvailable posh-git)) {
    Install-Module -Name posh-git -Scope CurrentUser -Force
}
