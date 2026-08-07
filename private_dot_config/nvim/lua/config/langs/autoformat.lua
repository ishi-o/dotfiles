local fmt = require("conform")
fmt.setup({
	formatters_by_ft = {
		c = { "clang-format" },
		cpp = { "clang-format" },
		css = { "prettier" },
		go = { "goimports", "gofumpt" },
		html = { "prettier" },
		java = { "google-java-format" },
		javascript = { "prettier" },
		json = { "jq" },
		markdown = {
			"prettier",
			-- "injected", -- Formats embedded code blocks using their language-specific formatters.
		},
		nginx = { "nginxfmt" },
		proto = { "buf" },
		python = {
			"ruff_fix",
			"ruff_format",
			"ruff_organize_imports",
		},
		scss = { "prettier" },
		toml = { "taplo" },
		typescript = { "prettier" },
		typst = { "typstyle" },
		vue = { "prettier" },
	},

	format_on_save = {
		timeout_ms = 3000,
		lsp_format = "fallback",
	},
})
