param(
    [Parameter(Position = 0)]
    [AllowEmptyString()]
    [string]$Http = "",

    [Parameter(Position = 1)]
    [AllowEmptyString()]
    [string]$Socks = "",

    [string]$NoProxy = "",
    [switch]$Clear,
    [switch]$Show,
    [switch]$Sync,
    [switch]$Help
)

$ErrorActionPreference = "Stop"

function Show-Usage {
    @'
Usage: Set-Proxy.ps1 [options] [HTTP_PROXY [SOCKS_PROXY]]

Options:
  -Http <url>         HTTP/HTTPS proxy, for example http://127.0.0.1:10808
  -Socks <url>        SOCKS proxy, for example socks5://127.0.0.1:10808
  -NoProxy <list>     Comma-separated hosts which bypass the proxy
  -Clear              Remove all proxy settings
  -Show               Show the saved proxy configuration
  -Sync               Regenerate Git and npm configuration

The configuration is stored in %USERPROFILE%\.config\proxy\config.
'@ | Write-Host
}

function Get-ProxyConfigurationPath {
    $configHome = Join-Path $env:USERPROFILE ".config"
    Join-Path $configHome "proxy\config"
}

function Assert-ProxyUrl {
    param(
        [Parameter(Mandatory = $true)]
        [AllowEmptyString()]
        [string]$Value,

        [Parameter(Mandatory = $true)]
        [ValidateSet("HTTP_PROXY", "SOCKS_PROXY")]
        [string]$Kind
    )

    if ([string]::IsNullOrEmpty($Value)) {
        return
    }
    if ($Value -match '\s|["'']|\\') {
        throw "$Kind must not contain whitespace, quotes, or backslashes"
    }

    $allowedSchemes = if ($Kind -eq "SOCKS_PROXY") {
        @("socks5", "socks5h")
    } else {
        @("http", "https")
    }
    try {
        $uri = [Uri]$Value
        if (-not $uri.IsAbsoluteUri -or $allowedSchemes -notcontains $uri.Scheme) {
            throw "$Kind must use one of: $($allowedSchemes -join '://, ')://"
        }
        if ([string]::IsNullOrWhiteSpace($uri.Host)) {
            throw "$Kind must contain a host"
        }
    } catch [FormatException] {
        throw "$Kind is not a valid URL"
    }
}

function Read-ProxyConfiguration {
    param([Parameter(Mandatory = $true)][string]$Path)

    $values = @{
        Http    = ""
        Socks   = ""
        NoProxy = ""
    }
    if (-not (Test-Path -LiteralPath $Path -PathType Leaf)) {
        throw "No proxy configuration found at $Path"
    }

    foreach ($line in Get-Content -LiteralPath $Path) {
        if ($line -match "^\s*PROXY_HTTP='(.*)'\s*$") {
            $values.Http = $Matches[1]
        } elseif ($line -match "^\s*PROXY_SOCKS='(.*)'\s*$") {
            $values.Socks = $Matches[1]
        } elseif ($line -match "^\s*PROXY_NO_PROXY='(.*)'\s*$") {
            $values.NoProxy = $Matches[1]
        }
    }
    $values
}

function Write-ProxyConfiguration {
    param(
        [Parameter(Mandatory = $true)][string]$Path,
        [Parameter(Mandatory = $true)][AllowEmptyString()][string]$Http,
        [Parameter(Mandatory = $true)][AllowEmptyString()][string]$Socks,
        [Parameter(Mandatory = $true)][AllowEmptyString()][string]$NoProxy
    )

    $directory = Split-Path -Parent $Path
    New-Item -ItemType Directory -Path $directory -Force | Out-Null
    $temporary = Join-Path $directory ".config.$([IO.Path]::GetRandomFileName())"
    try {
        @(
            "PROXY_HTTP='$Http'"
            "PROXY_SOCKS='$Socks'"
            "PROXY_NO_PROXY='$NoProxy'"
        ) | Set-Content -LiteralPath $temporary -Encoding ascii
        Move-Item -LiteralPath $temporary -Destination $Path -Force
    } finally {
        if (Test-Path -LiteralPath $temporary) {
            Remove-Item -LiteralPath $temporary -Force
        }
    }
}

function Set-ManagedEnvironment {
    param([Parameter(Mandatory = $true)][hashtable]$Values)

    $entries = [ordered]@{
        HTTP_PROXY  = [string]$Values.Http
        HTTPS_PROXY = [string]$Values.Http
        ALL_PROXY   = [string]$Values.Socks
        NO_PROXY    = $null
    }
    if ($Values.Http -or $Values.Socks) {
        $entries.NO_PROXY = if ($Values.NoProxy) { $Values.NoProxy } else { "localhost,127.0.0.1,::1" }
    }

    foreach ($entry in $entries.GetEnumerator()) {
        $value = [string]$entry.Value
        [Environment]::SetEnvironmentVariable($entry.Key, $entry.Value, "User")
        if ([string]::IsNullOrEmpty($value)) {
            Remove-Item -Path "Env:\$($entry.Key)" -ErrorAction SilentlyContinue
        } else {
            Set-Item -Path "Env:\$($entry.Key)" -Value $value
        }
    }
}

function Update-GitProxyConfiguration {
    param(
        [Parameter(Mandatory = $true)][string]$ConfigFile,
        [Parameter(Mandatory = $true)][hashtable]$Values
    )

    $proxy = if ($Values.Http) { $Values.Http } else { $Values.Socks }
    if ($proxy) {
        "[http]`n    proxy = `"$proxy`"" | Set-Content -LiteralPath $ConfigFile -Encoding ascii
    } else {
        "" | Set-Content -LiteralPath $ConfigFile -Encoding ascii
    }
}

function Update-NpmProxyConfiguration {
    param([Parameter(Mandatory = $true)][hashtable]$Values)

    $npmConfig = Join-Path $env:USERPROFILE ".config\npm\npmrc"
    $env:NPM_CONFIG_USERCONFIG = $npmConfig
    [Environment]::SetEnvironmentVariable("NPM_CONFIG_USERCONFIG", $npmConfig, "User")
    New-Item -ItemType Directory -Path (Split-Path -Parent $npmConfig) -Force | Out-Null

    if (Get-Command npm -ErrorAction SilentlyContinue) {
        if ($Values.Http) {
            npm config set proxy $Values.Http --location=user
            if ($LASTEXITCODE -ne 0) {
                throw "npm failed to update its proxy configuration"
            }
            npm config set https-proxy $Values.Http --location=user
            if ($LASTEXITCODE -ne 0) {
                throw "npm failed to update its HTTPS proxy configuration"
            }
        } else {
            npm config delete proxy --location=user
            if ($LASTEXITCODE -ne 0) {
                throw "npm failed to remove its proxy configuration"
            }
            npm config delete https-proxy --location=user
            if ($LASTEXITCODE -ne 0) {
                throw "npm failed to remove its HTTPS proxy configuration"
            }
        }
        return
    }

    if (-not $Values.Http -and -not (Test-Path -LiteralPath $npmConfig -PathType Leaf)) {
        return
    }
    $lines = @()
    if (Test-Path -LiteralPath $npmConfig -PathType Leaf) {
        $lines = @(Get-Content -LiteralPath $npmConfig |
                Where-Object { $_ -notmatch '^\s*(proxy|https-proxy)\s*=' })
    }
    if ($Values.Http) {
        $lines += @("proxy=$($Values.Http)", "https-proxy=$($Values.Http)")
    }
    $lines | Set-Content -LiteralPath $npmConfig -Encoding ascii
}

$configPath = Get-ProxyConfigurationPath

$optionsSelected = $Clear -or $Show -or $Sync -or $Http -or $Socks -or $NoProxy
if ($Help -and $optionsSelected) {
    throw "-Help cannot be combined with other options"
}
if ($Help -or -not $optionsSelected) {
    Show-Usage
    return
}
if ($Show -and ($Clear -or $Sync -or $Http -or $Socks -or $NoProxy)) {
    throw "-Show cannot be combined with other options"
}
if ($Clear -and ($Sync -or $Http -or $Socks -or $NoProxy)) {
    throw "-Clear cannot be combined with other options"
}
if ($Sync -and ($Http -or $Socks -or $NoProxy)) {
    throw "-Sync cannot be combined with proxy values"
}
if (-not ($Clear -or $Show -or $Sync) -and -not ($Http -or $Socks)) {
    throw "Specify an HTTP proxy, a SOCKS proxy, or an action option"
}

if ($Show) {
    Get-Content -LiteralPath $configPath -ErrorAction Stop
    return
}

if ($Clear) {
    Write-ProxyConfiguration -Path $configPath -Http "" -Socks "" -NoProxy ""
    $values = Read-ProxyConfiguration -Path $configPath
    Set-ManagedEnvironment -Values $values
} elseif ($Sync) {
    $values = Read-ProxyConfiguration -Path $configPath
    Set-ManagedEnvironment -Values $values
} else {
    Assert-ProxyUrl -Value $Http -Kind HTTP_PROXY
    Assert-ProxyUrl -Value $Socks -Kind SOCKS_PROXY
    if (-not $NoProxy) {
        $NoProxy = "localhost,127.0.0.1,::1"
    }
    if ($NoProxy -match '[\r\n]') {
        throw "-NoProxy must be a single comma-separated line"
    }
    Write-ProxyConfiguration -Path $configPath -Http $Http -Socks $Socks -NoProxy $NoProxy
    $values = Read-ProxyConfiguration -Path $configPath
    Set-ManagedEnvironment -Values $values
}

$gitConfig = Join-Path (Split-Path -Parent $configPath) "gitconfig"
Update-GitProxyConfiguration -ConfigFile $gitConfig -Values $values
Update-NpmProxyConfiguration -Values $values

Write-Host "Proxy configuration: $configPath"
Write-Host "Updated: Git, npm"
