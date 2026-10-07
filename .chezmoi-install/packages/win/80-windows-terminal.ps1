$ErrorActionPreference = "Stop"

. (Join-Path $PSScriptRoot "..\..\lib\win\helpers.ps1")

Install-ScoopPackage -Package "extras/windows-terminal"

$terminalRoot = (scoop prefix windows-terminal).Trim()
if (-not $terminalRoot -or -not (Test-Path -LiteralPath $terminalRoot)) {
    throw "Windows Terminal root not found"
}

$portableMarker = Join-Path $terminalRoot ".portable"
if (Test-Path -LiteralPath $portableMarker -PathType Leaf) {
    Remove-Item -LiteralPath $portableMarker -Force
}

$settingsDir = Join-Path $env:LOCALAPPDATA "Microsoft\Windows Terminal"
New-Item -ItemType Directory -Path $settingsDir -Force | Out-Null

$startupKey = "HKCU:\Console\%%Startup"
New-Item -Path $startupKey -Force | Out-Null
New-ItemProperty -Path $startupKey -Name "DelegationConsole" -Value "{2EECF802-30D1-413C-8603-2E2412A088F7}" -PropertyType String -Force | Out-Null
New-ItemProperty -Path $startupKey -Name "DelegationTerminal" -Value "{E12CFF52-A866-4C77-9A8F-36C1DC0F5FB6}" -PropertyType String -Force | Out-Null
