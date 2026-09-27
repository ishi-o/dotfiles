$ErrorActionPreference = "Stop"

$script:MSYS2PackageNames = @(
    "zsh",
    "autoconf",
    "automake",
    "libevent",
    "ncurses",
    "tmux",
    "libgpg-error",
    "libgcrypt",
    "libassuan",
    "libksba",
    "libnpth",
    "texinfo",
    "pinentry",
    "tree"
)

function Test-MSYS2Package {
    param([Parameter(Mandatory = $true)][string]$Package)

    return $Package -in $script:MSYS2PackageNames
}

function Get-MSYS2GroupPackages {
    param(
        [Parameter(Mandatory = $true)]
        [ValidateSet("shell", "build", "tools", "dev", "fonts", "terminal", "all")]
        [string]$Group,
        [switch]$IncludeDevTools
    )

    $packages = switch ($Group) {
        "shell"    { @("zsh") }
        "build"    {
            @(
                "autoconf",
                "automake",
                "libevent",
                "ncurses",
                "libgpg-error",
                "libgcrypt",
                "libassuan",
                "libksba",
                "libnpth",
                "texinfo",
                "pinentry"
            )
        }
        "tools"    { @("tree") }
        "dev"      { @("tree") }
        "terminal" { @("tmux") }
        "all"      {
            $allPackages = @()
            foreach ($groupName in @("shell", "build", "terminal")) {
                $allPackages += Get-MSYS2GroupPackages -Group $groupName
            }
            if ($IncludeDevTools) {
                $allPackages += Get-MSYS2GroupPackages -Group "tools"
            }
            @($allPackages | Select-Object -Unique)
        }
    }

    return [string[]]$packages
}

function Install-MSYS2Packages {
    param(
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string[]]$Packages
    )

    foreach ($package in $Packages) {
        if ($package -notmatch '^[A-Za-z0-9][A-Za-z0-9+_.-]*$') {
            throw "Invalid MSYS2 package name: $package"
        }
    }

    $msys2Root = ""
    try {
        $msys2Root = (scoop prefix msys2).Trim()
    }
    catch {
        $msys2Root = ""
    }

    if (-not $msys2Root -or -not (Test-Path -LiteralPath $msys2Root -PathType Container)) {
        scoop install msys2
        if ($LASTEXITCODE -ne 0) {
            throw "scoop install msys2 failed"
        }
        $msys2Root = (scoop prefix msys2).Trim()
        if (-not $msys2Root -or -not (Test-Path -LiteralPath $msys2Root -PathType Container)) {
            throw "MSYS2 root not found"
        }
    }

    $msys2UsrBin = Join-Path $msys2Root "usr\bin"
    if (-not (Test-Path -LiteralPath $msys2UsrBin -PathType Container)) {
        throw "MSYS2 usr/bin not found at $msys2UsrBin"
    }

    $pacman = Join-Path $msys2UsrBin "pacman.exe"
    if (-not (Test-Path -LiteralPath $pacman -PathType Leaf)) {
        throw "MSYS2 pacman not found at $pacman"
    }

    $env:Path = "$msys2UsrBin;$env:Path"

    $previousMSystem = $env:MSYSTEM
    $env:MSYSTEM = "MSYS"
    try {
        & $pacman -Sy --needed --noconfirm @Packages
        if ($LASTEXITCODE -ne 0) {
            throw "MSYS2 package installation failed: $($Packages -join ', ')"
        }
    }
    finally {
        if ($null -eq $previousMSystem) {
            Remove-Item Env:\MSYSTEM -ErrorAction SilentlyContinue
        }
        else {
            $env:MSYSTEM = $previousMSystem
        }
    }
}
