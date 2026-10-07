$ErrorActionPreference = "Stop"

$zplugInit = Join-Path $env:USERPROFILE "usr\local\zplug\init.zsh"
if (-not (Test-Path -LiteralPath $zplugInit -PathType Leaf)) {
    return
}

$msys2Root = ""
try {
    $msys2Root = (scoop prefix msys2).Trim()
} catch {
    return
}

$msys2Zsh = Join-Path $msys2Root "usr\bin\zsh.exe"
if (-not (Test-Path -LiteralPath $msys2Zsh -PathType Leaf)) {
    return
}

$env:ZPLUG_AUTO_INSTALL = "1"
$previousMSystem = $env:MSYSTEM
$env:MSYSTEM = "MSYS"
try {
    & $msys2Zsh -i -l -c 'exit'
    if ($LASTEXITCODE -ne 0) {
        Write-Warning "zplug plugin installation failed"
    }
} finally {
    if ($null -eq $previousMSystem) {
        Remove-Item Env:\MSYSTEM -ErrorAction SilentlyContinue
    } else {
        $env:MSYSTEM = $previousMSystem
    }
    Remove-Item Env:\ZPLUG_AUTO_INSTALL -ErrorAction SilentlyContinue
}
