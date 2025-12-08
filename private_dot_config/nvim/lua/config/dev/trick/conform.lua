require("conform").setup({
	formatters_by_ft = {
		bash = { "shfmt" },
		c = { "clang-format" },
		cpp = { "clang-format" },
		css = { "prettier" },
		go = { "goimports" },
		html = { "prettier" },
		-- java = { "google-java-format" },
		javascript = { "prettier" },
		json = { "jq" },
		lua = { "stylua" },
		markdown = {
			"prettier",
			"markdownlint-cli2",
			"markdown-toc",
			"injected",
		},
		nginx = { "nginxfmt" },
		-- python = { "ruff" },
		-- python = { "autopep8" },
		python = {
			"ruff_fix",
			"ruff_format",
			"ruff_organize_imports",
		},
		rust = { "rustfmt" },
		scss = { "prettier" },
		-- sql = { "sql-formatter" },
		sql = { "sqlfluff" },
		toml = { "taplo" },
		typescript = { "prettier" },
		typst = { "typstyle" },
		yaml = { "yamlfmt" },
	},

	format_on_save = {
		timeout_ms = 2000,
		lsp_format = "fallback",
	},
})

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
