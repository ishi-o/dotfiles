local lint = require("lint")
local autocmd = _G.UserUtils.autocmd
lint.linters_by_ft = {
	c = { "cpplint" },
	cpp = { "cpplint" },
	css = { "stylelint" },
	docker = { "hadolint" },
	go = { "golangcilint" },
	html = { "htmlhint" },
	javascript = { "eslint_d" },
	javascriptreact = { "eslint_d" },
	json = { "jsonlint" },
	python = { "ruff" },
	scss = { "stylelint" },
	typescript = { "eslint_d" },
	typescriptreact = { "eslint_d" },
}
lint.linters.cpplint.args = {
	"--filter=-whitespace/tab,-whitespace/indent",
	"--linelength=120",
}
autocmd({ "BufWritePost", "BufReadPost" }, {
	callback = function()
		lint.try_lint()
	end,
})
