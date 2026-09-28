$ErrorActionPreference = "Stop"

$sourceDir = (chezmoi source-path).Trim()
if ($LASTEXITCODE -ne 0) {
    throw "chezmoi source-path failed"
}

$helpers = Join-Path $sourceDir ".chezmoi-install\lib\win\helpers.ps1"
if (-not (Test-Path -LiteralPath $helpers -PathType Leaf)) {
    throw "Windows installer helpers were not found: $helpers"
}

. $helpers
Upgrade-Nvim
