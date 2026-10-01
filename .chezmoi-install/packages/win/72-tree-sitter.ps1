$ErrorActionPreference = "Stop"

cargo install tree-sitter-cli
if ($LASTEXITCODE -ne 0) {
    throw "cargo install tree-sitter-cli failed"
}
