scoop install msys2

$msys2Root = (scoop prefix msys2)
$msys2Bash = Join-Path $msys2Root "usr\bin\bash.exe"

$env:MSYSTEM = "MINGW64"
$env:HOME = $env:USERPROFILE

& $msys2Bash -lc "pacman -Sy --needed --noconfirm zsh"

$nsswitchConfig = Join-Path $msys2Root "etc\nsswitch.conf"
$nsswitchBackup = "$nsswitchConfig.bak"

if (-not (Test-Path -LiteralPath $nsswitchBackup)) {
    Copy-Item -LiteralPath $nsswitchConfig -Destination $nsswitchBackup
}

$nsswitchContent = Get-Content -LiteralPath $nsswitchConfig
$nsswitchContent = $nsswitchContent | ForEach-Object {
    if ($_ -match '^\s*db_shell\s*:') {
        "db_shell: /usr/bin/zsh"
    }
    elseif ($_ -match '^\s*db_root\s*:') {
        "db_root: /usr/bin/zsh"
    }
    else {
        $_
    }
}
Set-Content -LiteralPath $nsswitchConfig -Value $nsswitchContent

[Environment]::SetEnvironmentVariable("MSYSTEM", "MINGW64", "User")
[Environment]::SetEnvironmentVariable("SHELL", "/usr/bin/zsh", "User")

[$nsswitch = "C:\msys64\etc\nsswitch.conf"
if (Test-Path $nsswitch) {
    $content = Get-Content $nsswitch -Raw
    $patched = $content -replace '(?m)^\s*#?\s*db_home\s*:.*$', 'db_home: env windows cygwin desc'
    if ($patched -ne $content) {
        Set-Content -Path $nsswitch -Value $patched -NoNewline
        Write-Host "==> Patched $nsswitch"
    } else {
        Write-Host "==> $nsswitch already configured"
    }
}Environment]::SetEnvironmentVariable("HOME", $env:USERPROFILE, "User")
