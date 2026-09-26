$ErrorActionPreference = "Stop"

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

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
    "kitty",
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
    Write-Host "==> Installing Scoop..."
    Invoke-RestMethod -Uri "https://get.scoop.sh" | Invoke-Expression
}

$fontPackages = @("06-cjk-fonts")
$devToolPackages = @(
    "60-fzf",
    "63-fd",
    "64-tree",
    "65-kubectl",
    "66-ripgrep",
    "67-xclip",
    "70-rust",
    "71-kitty",
    "72-tree-sitter",
    "73-gh"
)

$packages = Get-ChildItem -LiteralPath (Join-Path $scriptDir "packages\win") -Filter "*.ps1" | Sort-Object Name

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
    & $package.FullName
}
