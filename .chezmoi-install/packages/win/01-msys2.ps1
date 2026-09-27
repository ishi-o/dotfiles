scoop install msys2
if ($LASTEXITCODE -ne 0) {
    throw "scoop install msys2 failed"
}

$msys2Root = (scoop prefix msys2).Trim()
if (-not $msys2Root -or -not (Test-Path -LiteralPath $msys2Root)) {
    throw "MSYS2 root not found"
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

$env:MSYSTEM = "MSYS"
& $pacman -Sy --needed --noconfirm zsh
if ($LASTEXITCODE -ne 0) {
    throw "MSYS2 zsh installation failed"
}
Remove-Item Env:\MSYSTEM -ErrorAction SilentlyContinue

$msys2Zsh = Join-Path $msys2Root "usr\bin\zsh.exe"
if (-not (Test-Path -LiteralPath $msys2Zsh)) {
    throw "MSYS2 zsh not found at $msys2Zsh"
}

$zplugHome = Join-Path $env:USERPROFILE "usr\local\zplug"
$zplugInit = Join-Path $zplugHome "init.zsh"
if (-not (Test-Path -LiteralPath $zplugInit -PathType Leaf)) {
    if (Test-Path -LiteralPath $zplugHome) {
        Remove-Item -LiteralPath $zplugHome -Recurse -Force
    }
    New-Item -ItemType Directory -Path (Split-Path -Parent $zplugHome) -Force | Out-Null
    git clone --depth 1 https://github.com/zplug/zplug $zplugHome
    if ($LASTEXITCODE -ne 0) {
        throw "zplug installation failed"
    }
}

$nsswitchConfig = Join-Path $msys2Root "etc\nsswitch.conf"
$nsswitchBackup = "$nsswitchConfig.bak"

if (-not (Test-Path -LiteralPath $nsswitchBackup)) {
    Copy-Item -LiteralPath $nsswitchConfig -Destination $nsswitchBackup
}

$nsswitchContent = Get-Content -LiteralPath $nsswitchConfig
$nsswitchContent = $nsswitchContent | ForEach-Object {
    if ($_ -match '^\s*#?\s*db_home\s*:') {
        "db_home: env windows cygwin desc"
    }
    elseif ($_ -match '^\s*#?\s*db_shell\s*:') {
        "db_shell: /usr/bin/zsh"
    }
    elseif ($_ -match '^\s*#?\s*db_root\s*:') {
        "db_root: /usr/bin/zsh"
    }
    else {
        $_
    }
}
Set-Content -LiteralPath $nsswitchConfig -Value $nsswitchContent
