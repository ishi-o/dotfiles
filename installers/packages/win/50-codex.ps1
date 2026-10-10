$ErrorActionPreference = "Stop"

. (Join-Path $PSScriptRoot "..\..\lib\win\helpers.ps1")

if (-not (Test-Installed "pnpm")) {
    Write-Host "Skipping codex: pnpm not found (install pnpm first)"
    return
}

pnpm add -g @openai/codex
if ($LASTEXITCODE -ne 0) {
    throw "pnpm add @openai/codex failed"
}
