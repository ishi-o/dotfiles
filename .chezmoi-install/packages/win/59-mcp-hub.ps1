$ErrorActionPreference = "Stop"

. (Join-Path $PSScriptRoot "..\..\lib\win\helpers.ps1")
Initialize-Nvm

npm install -g mcp-hub
if ($LASTEXITCODE -ne 0) {
    throw "npm install mcp-hub failed"
}
