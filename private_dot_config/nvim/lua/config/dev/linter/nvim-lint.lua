local lint = require("lint")
lint.linters_by_ft = {
	bash = { "shellcheck" },
	c = { "cpplint" },
	cpp = { "cpplint" },
	css = { "stylelint" },
	docker = { "hadolint" },
	-- go = { "golangci-lint" },
	html = { "htmlhint" },
	java = { "checkstyle" },
	javascript = { "eslint_d" },
	javascriptreact = { "eslint_d" },
	json = { "jsonlint" },
	lua = { "luacheck" },
	markdown = { "markdownlint-cli2" },
	python = { "ruff" },
	scss = { "stylelint" },
	sh = { "shellcheck" },
	sql = { "sqlfluff" },
	-- sql = { "sqruff" },
	typescript = { "eslint_d" },
	typescriptreact = { "eslint_d" },
	yaml = { "yamllint" },
	zsh = { "shellcheck" },
}
require("lint.linters.checkstyle").args = {
	"-c",
	os.getenv("HOME") .. "/.config/checkstyle/checkstyle.xml",
	"-f",
	"json",
}
require("lint.linters.cpplint").args = {
	"--filter=-whitespace/tab,-whitespace/indent",
	"--linelength=120",
}
require("lint.linters.markdownlint").args = {
	"--disable",
	"MD010",
	"MD046",
	"--stdin",
}
require("lint.linters.markdownlint-cli2").args = {
	"--config",
	os.getenv("HOME") .. "/.config/markdownlint/.markdownlint-cli2.jsonc",
	"--stdin",
}
vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
	callback = function()
		lint.try_lint()
	end,
})
