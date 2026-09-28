$ErrorActionPreference = "Stop"

function Initialize-ScoopUpdateCheck {
    if ($env:DOTS_SCOOP_UPDATE_CHECKED -eq "1") {
        return
    }

    Write-Host "==> Checking for Scoop and bucket updates..."
    & scoop update
    if ($LASTEXITCODE -ne 0) {
        throw "scoop update failed"
    }

    $env:DOTS_SCOOP_UPDATE_CHECKED = "1"
}

function Install-ScoopPackage {
    param(
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string[]]$Package
    )

    Initialize-ScoopUpdateCheck
    & scoop install -u @Package
    if ($LASTEXITCODE -ne 0) {
        throw "scoop install failed: $($Package -join ', ')"
    }
}

function Get-ScoopRoot {
    if ($env:SCOOP) {
        return $env:SCOOP
    }
    if ($env:SCOOP_DIR) {
        return $env:SCOOP_DIR
    }

    Join-Path $env:USERPROFILE "scoop"
}

function Upgrade-Nvim {
    $ErrorActionPreference = "Stop"

    $nvimMsi = Join-Path $env:TEMP "nvim-win64.msi"
    $nvimDir = Join-Path $env:LOCALAPPDATA "Neovim"

    Write-Host "==> Downloading Neovim nightly..."
    Invoke-WebRequest -Uri "https://github.com/neovim/neovim/releases/download/nightly/nvim-win64.msi" -OutFile $nvimMsi

    Write-Host "==> Installing Neovim nightly to $nvimDir..."
    $process = Start-Process msiexec -ArgumentList "/i", "`"$nvimMsi`"", "/passive", "INSTALLDIR=`"$nvimDir`"" -Wait -PassThru
    if ($process.ExitCode -ne 0) {
        Remove-Item $nvimMsi -Force -ErrorAction SilentlyContinue
        throw "Neovim nightly installation failed with exit code $($process.ExitCode)"
    }

    Remove-Item $nvimMsi -Force

    $nvimBin = Join-Path $nvimDir "bin"
    $currentPath = [Environment]::GetEnvironmentVariable("Path", "User")
    if ($currentPath -notlike "*$nvimBin*") {
        [Environment]::SetEnvironmentVariable("Path", "$currentPath;$nvimBin", "User")
        Write-Host "==> Added $nvimBin to user PATH."
    }

    Write-Host "==> Neovim nightly installed successfully."
}

# Node.js helpers.
function Initialize-Nvm {
    param([switch]$InstallNode)

    $nvmHome = (scoop prefix nvm).Trim()
    if (-not $nvmHome -or -not (Test-Path -LiteralPath $nvmHome -PathType Container)) {
        throw "NVM home not found"
    }

    $env:NVM_HOME = $nvmHome
    $env:NVM_SYMLINK = Join-Path $nvmHome "nodejs"
    [Environment]::SetEnvironmentVariable("NVM_HOME", $env:NVM_HOME, "User")
    [Environment]::SetEnvironmentVariable("NVM_SYMLINK", $env:NVM_SYMLINK, "User")
    $env:Path = "$env:NVM_HOME;$env:NVM_SYMLINK;$env:Path"

    $nvm = Join-Path $nvmHome "nvm.exe"

    $nvmSettings = Join-Path $nvmHome "settings.txt"
    if (Test-Path -LiteralPath $nvmSettings -PathType Leaf) {
        $settings = @(Get-Content -LiteralPath $nvmSettings)
        $officialSettings = @($settings | Where-Object {
                $_ -notmatch '^\s*(?:node_mirror|npm_mirror)\s*:'
            })
        if ($officialSettings.Count -ne $settings.Count) {
            Set-Content -LiteralPath $nvmSettings -Value $officialSettings
        }
    }

    if ($InstallNode) {
        & $nvm install 22
        if ($LASTEXITCODE -ne 0) {
            throw "nvm install 22 failed"
        }
    }

    & $nvm use 22
    if ($LASTEXITCODE -ne 0) {
        throw "nvm use 22 failed"
    }

    if (-not (Get-Command npm -ErrorAction SilentlyContinue)) {
        throw "npm was not found after enabling NVM"
    }

    npm config set registry https://registry.npmjs.org/
    if ($LASTEXITCODE -ne 0) {
        throw "npm official registry configuration failed"
    }
}

# MSYS2 helpers.
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
        "shell" {
            @("zsh") 
        }
        "build" {
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
        "tools" {
            @("tree") 
        }
        "dev" {
            @("tree") 
        }
        "terminal" {
            @("tmux") 
        }
        "all" {
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
    } catch {
        $msys2Root = ""
    }

    if (-not $msys2Root -or -not (Test-Path -LiteralPath $msys2Root -PathType Container)) {
        Install-ScoopPackage -Package "msys2"
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
    } finally {
        if ($null -eq $previousMSystem) {
            Remove-Item Env:\MSYSTEM -ErrorAction SilentlyContinue
        } else {
            $env:MSYSTEM = $previousMSystem
        }
    }
}
