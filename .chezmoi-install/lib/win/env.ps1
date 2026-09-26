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

$proxyEnvironment = [ordered]@{
    HTTP_PROXY  = "http://127.0.0.1:10808"
    HTTPS_PROXY = "http://127.0.0.1:10808"
    ALL_PROXY    = "socks5://127.0.0.1:10808"
    NO_PROXY     = "localhost,127.0.0.1,::1"
}

foreach ($entry in $proxyEnvironment.GetEnumerator()) {
    Set-UserEnvironmentVariable -Name $entry.Key -Value $entry.Value
}
