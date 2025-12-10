local null_ls = require("null-ls")

null_ls.setup({
	sources = {
		-- Java - checkstyle
		null_ls.builtins.diagnostics.checkstyle.with({
			extra_args = { "-c", os.getenv("HOME") .. "/.config/checkstyle/checkstyle.xml" },
		}),

		-- Shell - shellcheck
		null_ls.builtins.diagnostics.shellcheck,

		-- Go - golangci-lint
		-- null_ls.builtins.diagnostics.golangci_lint.with({
		-- 	args = { "run", "--fix=false", "--show-stats=false", "--output.json.path=stdout" },
		-- 	cwd = function(params)
		-- 		return require("none-ls.utils").root_pattern(".golangci.yml")(params.bufname)
		-- 	end,
		-- }),

		-- Markdown - markdownlint
		null_ls.builtins.diagnostics.markdownlint,

		-- Python - ruff
		null_ls.builtins.diagnostics.ruff,

		-- Lua - luacheck
		null_ls.builtins.diagnostics.luacheck,
	},
})
