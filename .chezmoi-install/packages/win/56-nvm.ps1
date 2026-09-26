$ErrorActionPreference = "Stop"

scoop install nvm
if ($LASTEXITCODE -ne 0) {
    throw "scoop install nvm failed"
}

$env:NVM_HOME = (scoop prefix nvm).Trim()
$env:NVM_SYMLINK = Join-Path (scoop config root).Trim() "persist\nvm\.nodejs"
$env:Path = "$env:NVM_HOME;$env:NVM_SYMLINK;$env:Path"

& (Join-Path $env:NVM_HOME "nvm.exe") install 22
if ($LASTEXITCODE -ne 0) {
    throw "nvm install 22 failed"
}

& (Join-Path $env:NVM_HOME "nvm.exe") use 22
if ($LASTEXITCODE -ne 0) {
    throw "nvm use 22 failed"
}
