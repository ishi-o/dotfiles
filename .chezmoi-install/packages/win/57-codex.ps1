$ErrorActionPreference = "Stop"

$env:NVM_HOME = (scoop prefix nvm).Trim()
$env:NVM_SYMLINK = Join-Path (scoop config root).Trim() "persist\nvm\.nodejs"
$env:Path = "$env:NVM_HOME;$env:NVM_SYMLINK;$env:Path"

npm install -g @openai/codex
if ($LASTEXITCODE -ne 0) {
    throw "npm install @openai/codex failed"
}
