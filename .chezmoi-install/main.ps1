$ErrorActionPreference = "Stop"

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

$bin = Join-Path $env:USERPROFILE ".local\bin"
$u = [Environment]::GetEnvironmentVariable("Path", "User")
if ($u -notlike "*$bin*") {
    [Environment]::SetEnvironmentVariable("Path", "$bin;$u", "User")
    $env:Path = "$bin;$env:Path"
    Write-Host "==> Added $bin to user PATH"
}

. (Join-Path $scriptDir "lib\win\env.ps1")
. (Join-Path $scriptDir "lib\win\helpers.ps1")

function Confirm-Install {
    param([Parameter(Mandatory = $true)][string]$Prompt)

    if (-not [Environment]::UserInteractive) {
        return $true
    }

    $answer = Read-Host "$Prompt [Y/n]"
    if ([string]::IsNullOrWhiteSpace($answer)) {
        return $true
    }

    return $answer -notmatch '^(?i:n(o)?)$'
}

function Test-AnyCommandMissing {
    param([Parameter(Mandatory = $true)][string[]]$Commands)

    foreach ($command in $Commands) {
        if (-not (Get-Command $command -ErrorAction SilentlyContinue)) {
            return $true
        }
    }
    return $false
}

function Test-MSYS2Available {
    if (Get-Command pacman -ErrorAction SilentlyContinue) {
        return $true
    }
    if (Get-Command scoop -ErrorAction SilentlyContinue) {
        try {
            $msys2Root = (scoop prefix msys2).Trim()
            return [bool]$msys2Root -and
            (Test-Path -LiteralPath (Join-Path $msys2Root "usr\bin\pacman.exe") -PathType Leaf)
        } catch {
            return $false
        }
    }
    return $false
}

$installMsys2 = $true
if (-not (Test-MSYS2Available) -and
    -not (Confirm-Install "Install missing MSYS2 environment?")) {
    $installMsys2 = $false
}

$installMsvc = $false
if (-not (Test-MSVCAvailable)) {
    $installMsvc = Confirm-Install "Install missing MSVC build tools?"
}

$installMingw = $true
if ((Test-AnyCommandMissing @("gcc")) -and
    -not (Confirm-Install "Install missing MinGW toolchain?")) {
    $installMingw = $false
}

$installBase = $true
if ((Test-AnyCommandMissing @("unzip", "m4", "pkg-config", "openssl", "msgfmt", "gpg")) -and
    -not (Confirm-Install "Install missing base tools?")) {
    $installBase = $false
}

$installRuntimes = $true
if ((Test-AnyCommandMissing @("uv", "mise", "nvm", "node", "luajit", "cargo")) -and
    -not (Confirm-Install "Install missing language runtimes?")) {
    $installRuntimes = $false
}

$installEditor = $true
if ((Test-AnyCommandMissing @("nvim", "tree-sitter")) -and
    -not (Confirm-Install "Install missing editor tooling?")) {
    $installEditor = $false
}

$installAi = $true
if ((Test-AnyCommandMissing @("codex", "claude", "mcp-hub", "codegraph")) -and
    -not (Confirm-Install "Install missing AI tools?")) {
    $installAi = $false
}

$installUtilities = $true
if ((Test-AnyCommandMissing @("fzf", "fd", "rg", "gh")) -and
    -not (Confirm-Install "Install missing command-line utilities?")) {
    $installUtilities = $false
}

$installOperations = $true
if ((Test-AnyCommandMissing @("kubectl", "ncat")) -and
    -not (Confirm-Install "Install missing operations tools?")) {
    $installOperations = $false
}

$installTerminal = $true
if ((Test-AnyCommandMissing @("wt")) -and
    -not (Confirm-Install "Install missing Windows Terminal?")) {
    $installTerminal = $false
}

if (-not (Get-Command scoop -ErrorAction SilentlyContinue)) {
    if ($env:SCOOP_DIR) {
        $env:SCOOP = $env:SCOOP_DIR
        [Environment]::SetEnvironmentVariable("SCOOP", $env:SCOOP_DIR, "User")
    }
    Write-Host "==> Installing Scoop..."
    Invoke-RestMethod -Uri "https://get.scoop.sh" | Invoke-Expression
}

if (-not (scoop bucket list | Where-Object { $_.Name -eq "extras" })) {
    scoop bucket add extras
}

Initialize-ScoopUpdateCheck

$msys2Packages = @()
if ($installMsys2) {
    $msys2Packages = Get-MSYS2GroupPackages -Group "all" -IncludeDevTools
}

$packageCategories = @{
    "01-msys2" = "msys2"
    "02-msvc" = "msvc"
    "03-mingw" = "mingw"
    "04-uv" = "runtimes"
    "05-mise" = "runtimes"
    "06-unzip" = "base"
    "10-m4" = "base"
    "13-pkg-config" = "base"
    "20-openssl" = "base"
    "40-gettext" = "base"
    "48-gpg" = "base"
    "50-nvim" = "editor"
    "56-nvm" = "runtimes"
    "57-codex" = "ai"
    "58-claude" = "ai"
    "59-mcp-hub" = "ai"
    "59-codegraph" = "ai"
    "60-fzf" = "utilities"
    "62-luajit" = "runtimes"
    "63-fd" = "utilities"
    "65-kubectl" = "operations"
    "66-ripgrep" = "utilities"
    "68-netcat" = "operations"
    "69-windows-terminal" = "terminal"
    "70-rust" = "runtimes"
    "72-tree-sitter" = "editor"
    "73-gh" = "utilities"
}

$packages = Get-ChildItem -LiteralPath (Join-Path $scriptDir "packages\win") -Filter "*.ps1" | Sort-Object Name
$failedPackages = @()

$msys2Installer = $packages | Where-Object { $_.BaseName -eq "01-msys2" } |
    Select-Object -First 1
if (-not $msys2Installer) {
    throw "MSYS2 installer not found"
}

Write-Host "==> Processing: MSYS2 ($($msys2Packages -join ', '))"
if ($msys2Packages.Count -gt 0) {
    try {
        & $msys2Installer.FullName -Packages $msys2Packages
    } catch {
        Write-Warning "Failed to install 01-msys2: $($_.Exception.Message)"
        $failedPackages += "01-msys2"
    }
}

foreach ($package in $packages) {
    if ($package.BaseName -eq "01-msys2") {
        continue
    }

    $category = $packageCategories[$package.BaseName]
    if (-not $category) {
        throw "No install category configured for package: $($package.BaseName)"
    }

    $categoryEnabled = switch ($category) {
        "msys2" {
            $installMsys2 
        }
        "msvc" {
            $installMsvc 
        }
        "mingw" {
            $installMingw 
        }
        "base" {
            $installBase 
        }
        "runtimes" {
            $installRuntimes 
        }
        "editor" {
            $installEditor 
        }
        "ai" {
            $installAi 
        }
        "utilities" {
            $installUtilities 
        }
        "operations" {
            $installOperations 
        }
        "terminal" {
            $installTerminal 
        }
        default {
            throw "Unknown install category: $category" 
        }
    }

    if (-not $categoryEnabled) {
        Write-Host "==> Skipping $($package.BaseName)"
        continue
    }

    Write-Host "==> Processing: $($package.BaseName)"
    try {
        & $package.FullName
    } catch {
        Write-Warning "Failed to install $($package.BaseName): $($_.Exception.Message)"
        $failedPackages += $package.BaseName
    }
}

if ($failedPackages.Count -gt 0) {
    Write-Warning "Failed packages: $($failedPackages -join ', ')"
    exit 1
}
