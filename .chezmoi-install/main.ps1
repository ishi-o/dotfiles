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

$installFonts = $true
if (-not (Get-Command fc-list -ErrorAction SilentlyContinue)) {
    $installFonts = Confirm-Install "Install missing CJK fonts?"
}

$devToolCommands = @(
    "fzf",
    "fd",
    "tree",
    "kubectl",
    "rg",
    "gh",
    "ncat",
    "wt",
    "rustup",
    "tree-sitter",
    "xclip"
)

$installDevTools = $true
$missingDevTools = @($devToolCommands |
    Where-Object { -not (Get-Command $_ -ErrorAction SilentlyContinue) })

if ($missingDevTools.Count -gt 0 -and
    -not (Confirm-Install "Install missing developer tools?")) {
    $installDevTools = $false
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

$fontPackages = @("06-cjk-fonts")
$devToolPackages = @(
    "60-fzf",
    "63-fd",
    "64-tree",
    "65-kubectl",
    "66-ripgrep",
    "67-xclip",
    "68-netcat",
    "69-windows-terminal",
    "70-rust",
    "72-tree-sitter",
    "73-gh"
)

$packages = Get-ChildItem -LiteralPath (Join-Path $scriptDir "packages\win") -Filter "*.ps1" | Sort-Object Name
$failedPackages = @()

foreach ($package in $packages) {
    if ($fontPackages -contains $package.BaseName -and -not $installFonts) {
        Write-Host "==> Skipping $($package.BaseName)"
        continue
    }

    if ($devToolPackages -contains $package.BaseName -and -not $installDevTools) {
        Write-Host "==> Skipping $($package.BaseName)"
        continue
    }

    Write-Host "==> Processing: $($package.BaseName)"
    try {
        & $package.FullName
    }
    catch {
        Write-Warning "Failed to install $($package.BaseName): $($_.Exception.Message)"
        $failedPackages += $package.BaseName
    }
}

if ($failedPackages.Count -gt 0) {
    Write-Warning "Failed packages: $($failedPackages -join ', ')"
    exit 1
}
