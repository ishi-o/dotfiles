$ErrorActionPreference = "Stop"

scoop install rustup-gnu
if ($LASTEXITCODE -ne 0) {
    throw "scoop install rustup-gnu failed"
}

rustup default stable
