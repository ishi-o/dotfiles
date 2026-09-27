$ErrorActionPreference = "Stop"

scoop install extras/windows-terminal
if ($LASTEXITCODE -ne 0) {
    throw "scoop install extras/windows-terminal failed"
}

$terminalRoot = (scoop prefix windows-terminal).Trim()
if (-not $terminalRoot -or -not (Test-Path -LiteralPath $terminalRoot)) {
    throw "Windows Terminal root not found"
}

# Scoop ships the unpackaged build in portable mode. Remove the marker so
# Windows Terminal uses the normal user settings directory instead of a
# settings directory beside the executable.
$portableMarker = Join-Path $terminalRoot ".portable"
if (Test-Path -LiteralPath $portableMarker -PathType Leaf) {
    Remove-Item -LiteralPath $portableMarker -Force
}

$settingsDir = Join-Path $env:LOCALAPPDATA "Microsoft\Windows Terminal"
New-Item -ItemType Directory -Path $settingsDir -Force | Out-Null

# Use the Scoop-installed Windows Terminal as the system default terminal.
$startupKey = "HKCU:\Console\%%Startup"
New-Item -Path $startupKey -Force | Out-Null
New-ItemProperty -Path $startupKey -Name "DelegationConsole" -Value "{2EECF802-30D1-413C-8603-2E2412A088F7}" -PropertyType String -Force | Out-Null
New-ItemProperty -Path $startupKey -Name "DelegationTerminal" -Value "{E12CFF52-A866-4C77-9A8F-36C1DC0F5FB6}" -PropertyType String -Force | Out-Null
