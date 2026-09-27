param(
    [Parameter(Mandatory = $true)][string]$TargetHost,
    [Parameter(Mandatory = $true)][string]$Port
)

$ErrorActionPreference = "Stop"
$configHome = Join-Path $env:USERPROFILE ".config"
$configPath = Join-Path $configHome "proxy\config"
$proxy = ""

if (Test-Path -LiteralPath $configPath -PathType Leaf) {
    foreach ($line in Get-Content -LiteralPath $configPath) {
        if ($line -match "^\s*PROXY_SOCKS='(.*)'\s*$") {
            $proxy = $Matches[1]
            break
        }
    }
}

if (-not $proxy) {
    & ncat.exe $TargetHost $Port
    exit $LASTEXITCODE
}

$proxyAddress = $proxy -replace '^[a-z0-9+.-]+://', ''
$proxyType = if ($proxy -match '^https?://') { "http" } else { "socks5" }
& ncat.exe --proxy-type $proxyType --proxy $proxyAddress $TargetHost $Port
exit $LASTEXITCODE
