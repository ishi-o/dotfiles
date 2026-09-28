$ErrorActionPreference = "Stop"

. (Join-Path $PSScriptRoot "..\..\lib\win\helpers.ps1")

Install-ScoopPackage -Package "rustup-gnu"

rustup default stable-x86_64-pc-windows-gnu
