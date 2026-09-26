if (-not (Get-Command codegraph -ErrorAction SilentlyContinue)) {
    npm install -g codegraph
}
