local luasnip = require("luasnip")
luasnip.setup({})
require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_vscode").lazy_load({
	paths = vim.fn.stdpath("config") .. "/snippets",
})
luasnip.filetype_extend("cpp", { "unreal" })
luasnip.filetype_extend("markdown", { "tex", "jekyll" })
luasnip.filetype_extend("mysql", { "sql" })
luasnip.filetype_extend("pgsql", { "sql" })
luasnip.filetype_extend("plsql", { "sql" })
