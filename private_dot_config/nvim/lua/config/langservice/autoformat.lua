local fmt = require("conform")
fmt.setup({
	formatters = {
		sqlfluff = {
			args = function()
				local filepath = vim.api.nvim_buf_get_name(0)
				local extension = string.match(filepath, "%.(%w+)$")
				extension = extension and string.lower(extension) or ""
				local dialect_map = {
					sql = "ansi",
					mysql = "mysql",
					psql = "postgres",
					bigquery = "bigquery",
				}
				local chosen_dialect = dialect_map[extension] or "ansi"
				return {
					"format",
					"--dialect=" .. chosen_dialect,
					"-",
				}
			end,
			cwd = function(self, ctx)
				local root = require("conform.util").root_file({
					".sqlfluff",
					"pyproject.toml",
					".git",
				})(self, ctx)
				return root or vim.fn.expand("~/.config/sqlfluff")
			end,
		},
	},
	formatters_by_ft = {
		bash = { "shfmt" },
		c = { "clang-format" },
		cpp = { "clang-format" },
		css = { "prettier" },
		go = { "goimports", "gofumpt" },
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
		mysql = { "sqlfluff" },
		nginx = { "nginxfmt" },
		pgsql = { "sqlfluff" },
		plsql = { "sqlfluff" },
		proto = { "buf" },
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
		xml = { "xmlformatter" },
		-- yaml = { "yamlfmt" },
	},

	format_on_save = {
		timeout_ms = 2000,
		lsp_format = "fallback",
	},
})
