local luasnip = require("luasnip")
luasnip.setup({})
luasnip.filetype_extend("go", { "go" })
require("luasnip.loaders.from_vscode").lazy_load()
