$ErrorActionPreference = "Stop"

. (Join-Path $PSScriptRoot "..\..\lib\win\helpers.ps1")
Initialize-Nvm

npm install -g codegraph
if ($LASTEXITCODE -ne 0) {
    throw "npm install codegraph failed"
}
