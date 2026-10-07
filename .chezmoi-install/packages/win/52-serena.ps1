$ErrorActionPreference = "Stop"

. (Join-Path $PSScriptRoot "..\..\lib\win\helpers.ps1")

if (Get-Command serena -ErrorAction SilentlyContinue) {
    return
}

uv tool install -p 3.13 serena-agent
if ($LASTEXITCODE -ne 0) {
    throw "uv tool install serena-agent failed"
}
