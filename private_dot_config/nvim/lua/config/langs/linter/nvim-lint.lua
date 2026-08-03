local function get_sql_dialect()
	local current_file = vim.api.nvim_buf_get_name(0)
	if string.find(current_file, "mysql/") then
		return "mysql"
	elseif string.find(current_file, "postgres/") then
		return "postgres"
	elseif string.match(current_file, "%.mysql%.sql$") then
		return "mysql"
	elseif string.match(current_file, "%.pg%.sql$") then
		return "postgres"
	elseif string.match(current_file, "%.oracle%.sql$") then
		return "oracle"
	else
		return "mysql"
	end
end

local lint = require("lint")
lint.linters_by_ft = {
	-- bash = { "shellcheck" },
	bash = {},
	c = { "cpplint" },
	cpp = { "cpplint" },
	css = { "stylelint" },
	docker = { "hadolint" },
	go = { "golangcilint" },
	html = { "htmlhint" },
	-- java = { "checkstyle" },
	javascript = { "eslint_d" },
	javascriptreact = { "eslint_d" },
	json = { "jsonlint" },
	-- lua = { "luacheck" },
	markdown = { "markdownlint-cli2" },
	mysql = { "sqlfluff" },
	pgsql = { "sqlfluff" },
	plsql = { "sqlfluff" },
	-- proto = { "buf_lint" },	-- lsp support
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
lint.linters.checkstyle.args = {
	"-c",
	os.getenv("HOME") .. "/.config/checkstyle/checkstyle.xml",
	"-f",
	"json",
}
lint.linters.cpplint.args = {
	"--filter=-whitespace/tab,-whitespace/indent",
	"--linelength=120",
}
lint.linters.markdownlint.args = {
	"--disable",
	"MD010",
	"MD046",
	"--stdin",
}
lint.linters["markdownlint-cli2"].args = {
	"--config",
	os.getenv("HOME") .. "/.config/markdownlint/.markdownlint-cli2.jsonc",
	"--stdin",
}
lint.linters["yamllint"].args = {
	"--config",
	os.getenv("HOME") .. "/.config/yaml/.yamllint.yaml",
	"--stdin",
}
lint.linters["sqlfluff"].args = {
	"lint",
	"--config",
	os.getenv("HOME") .. "/.config/sqlfluff/.sqlfluff",
	"--dialect",
	get_sql_dialect(),
	"--format",
	"json",
	"-",
}
lint.linters["sqlfluff"].stdin = true
vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
	callback = function()
		lint.try_lint()
	end,
})
