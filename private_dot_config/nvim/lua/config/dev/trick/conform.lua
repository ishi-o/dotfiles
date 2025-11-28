vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.java",
	callback = function(args)
		local clients = vim.lsp.get_clients({ name = "jdtls", bufnr = args.buf })
		if #clients == 0 then
			return
		end

		local client = clients[1]
		local params = {
			command = "java.edit.organizeImports",
			arguments = { vim.uri_from_bufnr(args.buf) },
		}
		client:request("workspace/executeCommand", params, function(err, result)
			vim.cmd("w")
		end, args.buf)
	end,
})

require("conform").setup({
	formatters_by_ft = {
		javascript = { "prettier" },
		typescript = { "prettier" },
		lua = { "stylua" },
		markdown = { "markdownlint" },
		-- python = { "ruff" },
		-- python = { "autopep8" },
		python = {
			"ruff_fix",
			"ruff_format",
			"ruff_organize_imports",
		},
		bash = { "shfmt" },
		go = { "goimports" },
		sql = { "sql-formatter" },
		c = { "clang-format" },
		cpp = { "clang-format" },
		-- java = { "google-java-format" },
	},

	format_on_save = {
		timeout_ms = 500,
		lsp_format = "fallback",
	},
})
