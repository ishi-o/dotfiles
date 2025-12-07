local luasnip = require("luasnip")
luasnip.setup({})
luasnip.filetype_extend("go", { "go" })
require("luasnip.loaders.from_vscode").lazy_load({
	paths = "rafamadriz/friendly-snippets",
	override_priority = 500,
})
require("luasnip.loaders.from_vscode").lazy_load({
	paths = { "~/.config/nvim/snippets" },
})
require("luasnip.loaders.from_vscode").lazy_load({
	paths = vim.fn.stdpath("config") .. "/snippets",
	override_priority = 1500,
})
