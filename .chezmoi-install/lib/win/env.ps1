$ErrorActionPreference = "Stop"

$scoopRoot = if ($env:SCOOP) {
    $env:SCOOP
} elseif ($env:SCOOP_DIR) {
    $env:SCOOP_DIR
} else {
    Join-Path $env:USERPROFILE "scoop"
}

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
    EDITOR           = "nvim"
    VISUAL           = "nvim"
    MISE_CONFIG_DIR = Join-Path $env:USERPROFILE ".config\mise"
    MISE_DATA_DIR   = Join-Path $env:USERPROFILE ".local\share\mise"
    MISE_CACHE_DIR  = Join-Path $env:USERPROFILE ".cache\mise"
    MISE_STATE_DIR  = Join-Path $env:USERPROFILE ".local\state\mise"
    CODEX_HOME      = Join-Path $env:USERPROFILE ".config\codex"
    CLAUDE_CONFIG_DIR = Join-Path $env:USERPROFILE ".config\claude"
    CC_SWITCH_CONFIG_DIR = Join-Path $env:USERPROFILE ".config\cc-switch"
    GH_CONFIG_DIR     = Join-Path $env:USERPROFILE ".config\gh"
    GOPATH            = Join-Path $env:USERPROFILE ".local\share\go"
    GOCACHE           = Join-Path $env:USERPROFILE ".cache\go-build"
}

if (Test-Path -LiteralPath $scoopRoot -PathType Container) {
    $scoopToolDirectories = [ordered]@{
        UV_CACHE_DIR      = Join-Path $scoopRoot "persist\uv\cache"
        UV_PYTHON_BIN_DIR = Join-Path $scoopRoot "persist\uv\python\shims"
        UV_PYTHON_INSTALL_DIR = Join-Path $scoopRoot "persist\uv\python\versions"
        UV_TOOL_BIN_DIR   = Join-Path $scoopRoot "persist\uv\tools\shims"
        UV_TOOL_DIR       = Join-Path $scoopRoot "persist\uv\tools\versions"
        NVM_HOME          = Join-Path $scoopRoot "apps\nvm\current"
        NVM_SYMLINK       = Join-Path $scoopRoot "persist\nvm\.nodejs"
        CARGO_HOME        = Join-Path $scoopRoot "persist\rustup-msvc\.cargo"
        RUSTUP_HOME       = Join-Path $scoopRoot "persist\rustup-msvc\.rustup"
        NPM_CONFIG_CACHE  = Join-Path $scoopRoot "persist\nvm\npm-cache"
    }
    foreach ($entry in $scoopToolDirectories.GetEnumerator()) {
        $toolDirectories[$entry.Key] = $entry.Value
    }
}

foreach ($entry in $toolDirectories.GetEnumerator()) {
    New-Item -ItemType Directory -Path $entry.Value -Force | Out-Null
    Set-UserEnvironmentVariable -Name $entry.Key -Value $entry.Value
}

if ($toolDirectories.Contains("UV_PYTHON_BIN_DIR")) {
    $env:Path = "$($toolDirectories["UV_PYTHON_BIN_DIR"]);$($toolDirectories["UV_TOOL_BIN_DIR"]);$env:Path"
}

$npmConfig = Join-Path $env:USERPROFILE ".config\npm\npmrc"
New-Item -ItemType Directory -Path (Split-Path -Parent $npmConfig) -Force | Out-Null
Set-UserEnvironmentVariable -Name "NPM_CONFIG_USERCONFIG" -Value $npmConfig

$proxyConfig = Join-Path $env:XDG_CONFIG_HOME "proxy\config"
if (Test-Path -LiteralPath $proxyConfig -PathType Leaf) {
    $proxy = @{
        Http    = ""
        Socks   = ""
        NoProxy = ""
    }
    foreach ($line in Get-Content -LiteralPath $proxyConfig) {
        if ($line -match "^\s*PROXY_HTTP='(.*)'\s*$") {
            $proxy.Http = $Matches[1]
        } elseif ($line -match "^\s*PROXY_SOCKS='(.*)'\s*$") {
            $proxy.Socks = $Matches[1]
        } elseif ($line -match "^\s*PROXY_NO_PROXY='(.*)'\s*$") {
            $proxy.NoProxy = $Matches[1]
        }
    }

    if ($proxy.Http) {
        Set-UserEnvironmentVariable -Name "HTTP_PROXY" -Value $proxy.Http
        Set-UserEnvironmentVariable -Name "HTTPS_PROXY" -Value $proxy.Http
    } else {
        [Environment]::SetEnvironmentVariable("HTTP_PROXY", $null, "User")
        [Environment]::SetEnvironmentVariable("HTTPS_PROXY", $null, "User")
        Remove-Item Env:\HTTP_PROXY -ErrorAction SilentlyContinue
        Remove-Item Env:\HTTPS_PROXY -ErrorAction SilentlyContinue
    }
    if ($proxy.Socks) {
        Set-UserEnvironmentVariable -Name "ALL_PROXY" -Value $proxy.Socks
    } else {
        [Environment]::SetEnvironmentVariable("ALL_PROXY", $null, "User")
        Remove-Item Env:\ALL_PROXY -ErrorAction SilentlyContinue
    }
    if ($proxy.Http -or $proxy.Socks) {
        $noProxyValue = if ($proxy.NoProxy) {
            $proxy.NoProxy 
        } else {
            "localhost,127.0.0.1,::1" 
        }
        Set-UserEnvironmentVariable -Name "NO_PROXY" -Value $noProxyValue
    } else {
        [Environment]::SetEnvironmentVariable("NO_PROXY", $null, "User")
        Remove-Item Env:\NO_PROXY -ErrorAction SilentlyContinue
    }
}
