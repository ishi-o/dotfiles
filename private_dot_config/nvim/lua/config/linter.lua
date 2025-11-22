local lint = require("lint")
lint.linters_by_ft = {
	javascript = { "eslint_d" },
	javascriptreact = { "eslint_d" },
	typescript = { "eslint_d" },
	typescriptreact = { "eslint_d" },
	sh = { "shellcheck" },
	zsh = { "shellcheck" },
	bash = { "shellcheck" },
	lua = { "luacheck" },
	python = { "ruff" },
	java = { "checkstyle" },
	-- go = { "golangci-lint" },
	markdown = { "markdownlint" },
}
vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
	callback = function()
		lint.try_lint()
	end,
})

-- local null_ls = require("null-ls")
--
-- null_ls.setup({
-- 	sources = {
-- 		-- Java - checkstyle
-- 		null_ls.builtins.diagnostics.checkstyle.with({
-- 			extra_args = { "-c", os.getenv("HOME") .. "/.config/checkstyle/checkstyle.xml" },
-- 		}),
--
-- 		-- Shell - shellcheck
-- 		null_ls.builtins.diagnostics.shellcheck,
--
-- 		-- Go - golangci-lint
-- 		-- null_ls.builtins.diagnostics.golangci_lint.with({
-- 		-- 	args = { "run", "--fix=false", "--show-stats=false", "--output.json.path=stdout" },
-- 		-- 	cwd = function(params)
-- 		-- 		return require("none-ls.utils").root_pattern(".golangci.yml")(params.bufname)
-- 		-- 	end,
-- 		-- }),
--
-- 		-- Markdown - markdownlint
-- 		null_ls.builtins.diagnostics.markdownlint,
--
-- 		-- Python - ruff
-- 		null_ls.builtins.diagnostics.ruff,
--
-- 		-- Lua - luacheck
-- 		null_ls.builtins.diagnostics.luacheck,
-- 	},
-- })
