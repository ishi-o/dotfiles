$ErrorActionPreference = "Stop"

. (Join-Path $PSScriptRoot "..\..\lib\win\helpers.ps1")

$packages = @(
    "@openai/codex",
    "@anthropic-ai/claude-code",
    "mcp-hub",
    "@colbymchenry/codegraph"
)

Install-MSYS2Packages -Packages @("mingw-w64-ucrt-x86_64-nodejs")
Install-MSYS2NpmPackages -Packages $packages
