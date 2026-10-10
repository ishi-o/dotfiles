$ErrorActionPreference = "Stop"

. (Join-Path $PSScriptRoot "..\..\lib\win\helpers.ps1")

if (-not (Test-Installed "pnpm")) {
    Write-Host "Skipping claude: pnpm not found (install pnpm first)"
    return
}

pnpm add -g @anthropic-ai/claude-code
if ($LASTEXITCODE -ne 0) {
    throw "pnpm add @anthropic-ai/claude-code failed"
}
