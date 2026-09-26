#!/usr/bin/env bash

set -euo pipefail

case "$(uname -s)" in
MINGW*|MSYS*|CYGWIN*)
  ;;
*)
  exit 0
  ;;
esac

powershell.exe -NoProfile -Command '
$ErrorActionPreference = "Stop"
$fontDir = Join-Path $env:LOCALAPPDATA "Microsoft\Windows\Fonts"
if (-not (Test-Path -LiteralPath $fontDir)) {
    exit 0
}

Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;

public static class FontApi
{
    [DllImport("gdi32.dll", SetLastError = true)]
    public static extern int AddFontResource(string lpFileName);
}
"@

$registryPath = "HKCU:\Software\Microsoft\Windows NT\CurrentVersion\Fonts"
Get-ChildItem -LiteralPath $fontDir -Filter "*.ttf" | ForEach-Object {
    [FontApi]::AddFontResource($_.FullName) | Out-Null
    New-ItemProperty -Path $registryPath -Name ($_.BaseName + " (TrueType)") -Value $_.FullName -PropertyType String -Force | Out-Null
}
'
