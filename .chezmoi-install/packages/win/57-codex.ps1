$ErrorActionPreference = "Stop"

. (Join-Path $PSScriptRoot "..\..\lib\win\node.ps1")
Initialize-Nvm

npm install -g @openai/codex
if ($LASTEXITCODE -ne 0) {
    throw "npm install @openai/codex failed"
}
