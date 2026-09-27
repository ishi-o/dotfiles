$profileContent = '. "$HOME\.config\powershell\profile.ps1"'

if (-not (Test-Path $PROFILE)) {
    New-Item -ItemType File -Path $PROFILE -Force | Out-Null
}

$currentContent = Get-Content -Path $PROFILE -Raw -ErrorAction SilentlyContinue

if ($currentContent -notmatch [regex]::Escape($profileContent)) {
    Add-Content -Path $PROFILE -Value $profileContent
}
