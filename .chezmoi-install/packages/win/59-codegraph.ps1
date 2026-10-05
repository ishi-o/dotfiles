$ErrorActionPreference = "Stop"

. (Join-Path $PSScriptRoot "..\..\lib\win\helpers.ps1")
Initialize-Nvm

npm install -g @colbymchenry/codegraph
if ($LASTEXITCODE -ne 0) {
    throw "npm install @colbymchenry/codegraph failed"
}
