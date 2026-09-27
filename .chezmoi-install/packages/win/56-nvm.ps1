$ErrorActionPreference = "Stop"

scoop install nvm
if ($LASTEXITCODE -ne 0) {
    throw "scoop install nvm failed"
}

. (Join-Path $PSScriptRoot "..\..\lib\win\node.ps1")
Initialize-Nvm -InstallNode
