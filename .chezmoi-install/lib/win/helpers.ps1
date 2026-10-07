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

function Initialize-ScoopToolPaths {
    $scoopRoot = Get-ScoopRoot
    $env:NVM_HOME = Join-Path $scoopRoot "apps\nvm\current"
    $env:NVM_SYMLINK = Join-Path $scoopRoot "persist\nvm\.nodejs"
    $env:CARGO_HOME = Join-Path $scoopRoot "persist\rustup-msvc\.cargo"
    $env:RUSTUP_HOME = Join-Path $scoopRoot "persist\rustup-msvc\.rustup"
    $env:NPM_CONFIG_CACHE = Join-Path $scoopRoot "persist\nvm\npm-cache"

    [Environment]::SetEnvironmentVariable("NVM_HOME", $env:NVM_HOME, "User")
    [Environment]::SetEnvironmentVariable("NVM_SYMLINK", $env:NVM_SYMLINK, "User")
    [Environment]::SetEnvironmentVariable("CARGO_HOME", $env:CARGO_HOME, "User")
    [Environment]::SetEnvironmentVariable("RUSTUP_HOME", $env:RUSTUP_HOME, "User")
    [Environment]::SetEnvironmentVariable("NPM_CONFIG_CACHE", $env:NPM_CONFIG_CACHE, "User")

    $env:Path = @(
        $env:NVM_HOME,
        $env:NVM_SYMLINK,
        (Join-Path $env:CARGO_HOME "bin"),
        $env:Path
    ) -join [IO.Path]::PathSeparator
}

function Test-MSVCAvailable {
    $vswhere = Join-Path ${env:ProgramFiles(x86)} "Microsoft Visual Studio\Installer\vswhere.exe"
    if (-not (Test-Path -LiteralPath $vswhere -PathType Leaf)) {
        return $false
    }

    $installationPath = & $vswhere -products * `
        -requires Microsoft.VisualStudio.Component.VC.Tools.x86.x64 `
        -property installationPath
    return -not [string]::IsNullOrWhiteSpace(($installationPath | Select-Object -First 1))
}

function Upgrade-Nvim {
    $ErrorActionPreference = "Stop"

    $nvimMsi = Join-Path $env:TEMP "nvim-win64.msi"
    $nvimDir = Join-Path $env:LOCALAPPDATA "Neovim"
    $stampFile = Join-Path $nvimDir ".nightly-stamp"

    Write-Host "==> Checking remote Neovim nightly..."
    $head = Invoke-WebRequest -Uri "https://github.com/neovim/neovim/releases/download/nightly/nvim-win64.msi" -Method Head
    $remoteStamp = $head.Headers['Last-Modified']
    if ($remoteStamp -is [array]) {
        $remoteStamp = $remoteStamp[0] 
    }

    if (Test-Path $stampFile) {
        $localStamp = Get-Content -LiteralPath $stampFile -Raw
        if ($localStamp.Trim() -eq $remoteStamp) {
            Write-Host "==> Neovim nightly is already up to date."
            return
        }
    }

    Write-Host "==> Downloading Neovim nightly..."
    Invoke-WebRequest -Uri "https://github.com/neovim/neovim/releases/download/nightly/nvim-win64.msi" -OutFile $nvimMsi

    Write-Host "==> Installing Neovim nightly to $nvimDir..."
    $process = Start-Process msiexec -ArgumentList "/i", "`"$nvimMsi`"", "/passive", "INSTALLDIR=`"$nvimDir`"" -Wait -PassThru
    if ($process.ExitCode -ne 0 -and $process.ExitCode -ne 3010) {
        Remove-Item $nvimMsi -Force -ErrorAction SilentlyContinue
        throw "Neovim nightly installation failed with exit code $($process.ExitCode)"
    }

    Remove-Item $nvimMsi -Force

    New-Item -ItemType Directory -Path $nvimDir -Force | Out-Null
    Set-Content -LiteralPath $stampFile -Value $remoteStamp -NoNewline

    $nvimBin = Join-Path $nvimDir "bin"
    $currentPath = [Environment]::GetEnvironmentVariable("Path", "User")
    if ($currentPath -notlike "*$nvimBin*") {
        [Environment]::SetEnvironmentVariable("Path", "$currentPath;$nvimBin", "User")
        Write-Host "==> Added $nvimBin to user PATH."
    }

    Write-Host "==> Neovim nightly installed successfully."
}

function Initialize-Nvm {
    param([switch]$InstallNode)

    Initialize-ScoopToolPaths
    $nvmHome = (scoop prefix nvm).Trim()
    if (-not $nvmHome -or -not (Test-Path -LiteralPath $nvmHome -PathType Container)) {
        throw "NVM home not found"
    }

    $env:NVM_HOME = $nvmHome
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
    "tree",
    "less"
)

function Test-MSYS2Package {
    param([Parameter(Mandatory = $true)][string]$Package)

    return $Package -in $script:MSYS2PackageNames
}

function Get-MSYS2GroupPackages {
    param(
        [Parameter(Mandatory = $true)]
        [ValidateSet("shell", "build", "tools", "dev", "editor", "runtimes", "ai", "operations", "terminal", "all")]
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
            @("tree", "less")
        }
        "dev" {
            @("tree", "less")
        }
        "editor" {
            @()
        }
        "runtimes" {
            @()
        }
        "ai" {
            @()
        }
        "operations" {
            @()
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

    $bash = Join-Path $msys2UsrBin "bash.exe"
    if (-not (Test-Path -LiteralPath $bash -PathType Leaf)) {
        throw "MSYS2 bash not found at $bash"
    }

    $env:Path = "$msys2UsrBin;$env:Path"

    $installArgs = @("-lc", 'pacman -Sy --needed --noconfirm "$@"', "pacman") + $Packages
    $previousMSystem = $env:MSYSTEM
    $env:MSYSTEM = "MSYS"
    try {
        & $bash @installArgs
        if ($LASTEXITCODE -ne 0) {
            & $bash -lc 'pacman-key --init >/dev/null 2>&1; pacman-key --populate msys2'
            & $bash @installArgs
            if ($LASTEXITCODE -ne 0) {
                throw "MSYS2 package installation failed: $($Packages -join ', ')"
            }
        }
    } finally {
        if ($null -eq $previousMSystem) {
            Remove-Item Env:\MSYSTEM -ErrorAction SilentlyContinue
        } else {
            $env:MSYSTEM = $previousMSystem
        }
    }
}

function Install-MSYS2NpmPackages {
    param(
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string[]]$Packages
    )

    foreach ($package in $Packages) {
        if ($package -notmatch '^[A-Za-z0-9@][A-Za-z0-9+_.-]*(/[A-Za-z0-9+_.-]+)?$') {
            throw "Invalid npm package name: $package"
        }
    }

    $msys2Root = (scoop prefix msys2).Trim()
    if (-not $msys2Root -or -not (Test-Path -LiteralPath $msys2Root -PathType Container)) {
        throw "MSYS2 root not found"
    }

    $bash = Join-Path $msys2Root "usr\bin\bash.exe"
    if (-not (Test-Path -LiteralPath $bash -PathType Leaf)) {
        throw "MSYS2 bash not found at $bash"
    }

    $previousMSystem = $env:MSYSTEM
    $env:MSYSTEM = "UCRT64"
    try {
        & $bash -lc 'npm install -g "$@"' npm @Packages
        if ($LASTEXITCODE -ne 0) {
            throw "MSYS2 npm installation failed: $($Packages -join ', ')"
        }
    } finally {
        if ($null -eq $previousMSystem) {
            Remove-Item Env:\MSYSTEM -ErrorAction SilentlyContinue
        } else {
            $env:MSYSTEM = $previousMSystem
        }
    }
}
