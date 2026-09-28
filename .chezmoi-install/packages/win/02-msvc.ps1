$ErrorActionPreference = "Stop"

. (Join-Path $PSScriptRoot "..\..\lib\win\helpers.ps1")

Install-ScoopPackage -Package @("vs_2022_cpp_build_tools")
