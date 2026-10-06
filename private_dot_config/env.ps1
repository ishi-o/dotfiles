$dotfilesEnvLocal = Join-Path $PSScriptRoot "env.local.ps1"
if (Test-Path -LiteralPath $dotfilesEnvLocal -PathType Leaf) {
    . $dotfilesEnvLocal
}
