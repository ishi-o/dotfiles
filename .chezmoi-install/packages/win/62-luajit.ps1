$ErrorActionPreference = "Stop"

. (Join-Path $PSScriptRoot "..\..\lib\win\helpers.ps1")

Install-ScoopPackage -Package "luajit"
