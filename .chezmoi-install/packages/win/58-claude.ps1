$ErrorActionPreference = "Stop"

. (Join-Path $PSScriptRoot "..\..\lib\win\node.ps1")
Initialize-Nvm

npm install -g @anthropic-ai/claude-code
if ($LASTEXITCODE -ne 0) {
    throw "npm install @anthropic-ai/claude-code failed"
}
