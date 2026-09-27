$ErrorActionPreference = "Stop"

cargo install tree-sitter-cli --root (Join-Path $env:USERPROFILE "usr\local")
if ($LASTEXITCODE -ne 0) {
    throw "cargo install tree-sitter-cli failed"
}
