scoop install extras/libgcrypt
if ($LASTEXITCODE -ne 0) {
    throw "scoop install extras/libgcrypt failed"
}
