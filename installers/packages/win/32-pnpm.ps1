$ErrorActionPreference = "Stop"

. (Join-Path $PSScriptRoot "..\..\lib\win\helpers.ps1")

$nodeVersion = if ($env:NODE_VERSION) { $env:NODE_VERSION } else { "22" }

Install-ScoopPackage -Package "pnpm"

$pnpmHome = Join-Path $env:LOCALAPPDATA "pnpm"
$pnpmHomeBin = Join-Path $pnpmHome "bin"
$env:PNPM_HOME = $pnpmHome
$env:Path = "$pnpmHomeBin;$pnpmHome;$env:Path"

pnpm runtime set node $nodeVersion -g
if ($LASTEXITCODE -ne 0) {
    throw "pnpm runtime set node $nodeVersion failed"
}

if (-not (Test-Installed "npm")) {
    pnpm add -g npm
    if ($LASTEXITCODE -ne 0) {
        throw "pnpm add -g npm failed"
    }
}
