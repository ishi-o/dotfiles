$ErrorActionPreference = "Stop"

. (Join-Path $PSScriptRoot "..\..\lib\win\helpers.ps1")

if (-not (Test-Installed "pnpm")) {
    Write-Host "Skipping codegraph: pnpm not found (install pnpm first)"
    return
}

pnpm add -g @colbymchenry/codegraph
if ($LASTEXITCODE -ne 0) {
    throw "pnpm add @colbymchenry/codegraph failed"
}
