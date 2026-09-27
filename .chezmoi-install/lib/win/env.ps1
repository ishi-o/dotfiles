$ErrorActionPreference = "Stop"

function Set-UserEnvironmentVariable {
    param(
        [Parameter(Mandatory = $true)][string]$Name,
        [Parameter(Mandatory = $true)][string]$Value
    )
    [Environment]::SetEnvironmentVariable($Name, $Value, "User")
    Set-Item -Path "Env:\$Name" -Value $Value
}

$xdgDirectories = [ordered]@{
    XDG_CONFIG_HOME = Join-Path $env:USERPROFILE ".config"
    XDG_CACHE_HOME  = Join-Path $env:USERPROFILE ".cache"
    XDG_DATA_HOME   = Join-Path $env:USERPROFILE ".local\share"
    XDG_STATE_HOME  = Join-Path $env:USERPROFILE ".local\state"
    XDG_RUNTIME_DIR = Join-Path $env:USERPROFILE ".local\run"
}

foreach ($entry in $xdgDirectories.GetEnumerator()) {
    New-Item -ItemType Directory -Path $entry.Value -Force | Out-Null
    Set-UserEnvironmentVariable -Name $entry.Key -Value $entry.Value
}

$toolDirectories = [ordered]@{
    CARGO_HOME      = Join-Path $env:USERPROFILE ".local\share\cargo"
    RUSTUP_HOME     = Join-Path $env:USERPROFILE ".local\share\rustup"
    MISE_CONFIG_DIR = Join-Path $env:USERPROFILE ".config\mise"
    MISE_DATA_DIR   = Join-Path $env:USERPROFILE ".local\share\mise"
    MISE_CACHE_DIR  = Join-Path $env:USERPROFILE ".cache\mise"
    MISE_STATE_DIR  = Join-Path $env:USERPROFILE ".local\state\mise"
    UV_CACHE_DIR    = Join-Path $env:USERPROFILE ".cache\uv"
}

foreach ($entry in $toolDirectories.GetEnumerator()) {
    New-Item -ItemType Directory -Path $entry.Value -Force | Out-Null
    Set-UserEnvironmentVariable -Name $entry.Key -Value $entry.Value
}

$npmConfig = Join-Path $env:USERPROFILE ".config\npm\npmrc"
$npmCache = Join-Path $env:USERPROFILE ".cache\npm"
New-Item -ItemType Directory -Path (Split-Path -Parent $npmConfig) -Force | Out-Null
New-Item -ItemType Directory -Path $npmCache -Force | Out-Null
Set-UserEnvironmentVariable -Name "NPM_CONFIG_USERCONFIG" -Value $npmConfig
Set-UserEnvironmentVariable -Name "NPM_CONFIG_CACHE" -Value $npmCache

$proxyConfig = Join-Path $env:XDG_CONFIG_HOME "proxy\config"
if (Test-Path -LiteralPath $proxyConfig -PathType Leaf) {
    $proxy = @{
        Http = ""
        Socks = ""
        NoProxy = ""
    }
    foreach ($line in Get-Content -LiteralPath $proxyConfig) {
        if ($line -match "^\s*PROXY_HTTP='(.*)'\s*$") {
            $proxy.Http = $Matches[1]
        }
        elseif ($line -match "^\s*PROXY_SOCKS='(.*)'\s*$") {
            $proxy.Socks = $Matches[1]
        }
        elseif ($line -match "^\s*PROXY_NO_PROXY='(.*)'\s*$") {
            $proxy.NoProxy = $Matches[1]
        }
    }

    if ($proxy.Http) {
        Set-UserEnvironmentVariable -Name "HTTP_PROXY" -Value $proxy.Http
        Set-UserEnvironmentVariable -Name "HTTPS_PROXY" -Value $proxy.Http
    }
    else {
        [Environment]::SetEnvironmentVariable("HTTP_PROXY", $null, "User")
        [Environment]::SetEnvironmentVariable("HTTPS_PROXY", $null, "User")
        Remove-Item Env:\HTTP_PROXY -ErrorAction SilentlyContinue
        Remove-Item Env:\HTTPS_PROXY -ErrorAction SilentlyContinue
    }
    if ($proxy.Socks) {
        Set-UserEnvironmentVariable -Name "ALL_PROXY" -Value $proxy.Socks
    }
    else {
        [Environment]::SetEnvironmentVariable("ALL_PROXY", $null, "User")
        Remove-Item Env:\ALL_PROXY -ErrorAction SilentlyContinue
    }
    if ($proxy.Http -or $proxy.Socks) {
        $noProxyValue = if ($proxy.NoProxy) { $proxy.NoProxy } else { "localhost,127.0.0.1,::1" }
        Set-UserEnvironmentVariable -Name "NO_PROXY" -Value $noProxyValue
    }
    else {
        [Environment]::SetEnvironmentVariable("NO_PROXY", $null, "User")
        Remove-Item Env:\NO_PROXY -ErrorAction SilentlyContinue
    }
}
