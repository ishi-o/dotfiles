$ErrorActionPreference = "Stop"

scoop install rustup-gnu
if ($LASTEXITCODE -ne 0) {
    throw "scoop install rustup-gnu failed"
}

rustup default stable-x86_64-pc-windows-gnu
