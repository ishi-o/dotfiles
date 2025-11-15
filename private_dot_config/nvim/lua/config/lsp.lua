on_attach = function(client, bufnr)
    local opts = { buffer = bufnr, noremap = true, silent = true }

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "<Leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<Leader>ca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
end

require("mason").setup({})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "java",
	callback = function()
		-- check jdtls
		local mason_registry = require("mason-registry")
		if not mason_registry.is_installed("jdtls") then
			mason_registry.get_package("jdtls"):install()
		end

		local root_files = vim.fs.find({ ".git", "mvnw", "gradlew", "pom.xml" }, { upward = true })
		local root_dir = vim.fs.dirname(root_files[1])
		local config = {
			name = "jdtls",
			cmd = { "jdtls" },
			root_dir = root_dir,
			on_attach = on_attach,
			settings = {
				java = {
					signatureHelp = { enabled = true },
				}
			}
		}
		vim.lsp.start(config)
	end
})
