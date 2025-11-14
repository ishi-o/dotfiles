local on_attach = function(client, bufnr)
    local opts = { buffer = bufnr, noremap = true, silent = true }

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "<Leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<Leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
end

require"lspconfig".jdtls.setup {
    cmd = { "~/.local/bin/jdtls.sh" },
    on_attach = on_attach,

    root_dir = require("lspconfig.util").root_pattern(".git", "pom.xml", "build.gradle"),

    settings = {
        java = {
            signatureHelp = { enabled = true }
        }
    }
}
