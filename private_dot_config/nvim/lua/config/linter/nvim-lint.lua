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
	sql = { "sqruff" },
	c = { "cpplint" },
	cpp = { "cpplint" },
}
require("lint.linters.checkstyle").args = {
	"-c",
	os.getenv("HOME") .. "/.config/checkstyle/checkstyle.xml",
	"-f",
	"json",
}
vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
	callback = function()
		lint.try_lint()
	end,
})
