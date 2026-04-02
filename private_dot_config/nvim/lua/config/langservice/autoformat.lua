local fmt = require("conform")
fmt.setup({
	formatters = {
		sqlfluff = {
			args = function()
				local filetype = vim.api.nvim_get_option_value("filetype", { buf = 0, scope = "local" })
				filetype = string.lower(filetype)
				local dialect_map = {
					sql = "ansi",
					mysql = "mysql",
					pgsql = "postgres",
					postgresql = "postgres",
					bigquery = "bigquery",
				}
				local chosen_dialect = dialect_map[filetype] or "ansi"
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
		xmllint = {
			command = "xmllint",
			args = {
				"--format",
				"--encode",
				"UTF-8",
				"--nsclean",
				"--recover",
				"-",
			},
		},
		tidy = {
			command = "tidy",
			args = {
				"-xml",
				"-indent",
				"--indent-spaces",
				"4",
				"--quiet",
				"--tidy-mark",
				"no",
				"-utf8",
			},
		},
	},
	formatters_by_ft = {
		bash = { "shfmt" },
		c = { "clang-format" },
		cpp = { "clang-format" },
		css = { "prettier" },
		go = { "goimports", "gofumpt" },
		html = { "prettier" },
		java = { "google-java-format" },
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
		vue = { "prettier" },
		-- xml = { "xmlformatter" },
		-- xml = { "lsp" },
		-- xml = { "xmllint" },
		-- yaml = { "yamlfmt" },
	},

	format_on_save = {
		timeout_ms = 3000,
		lsp_format = "fallback",
	},
})
