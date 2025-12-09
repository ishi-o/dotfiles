local Rule = require("nvim-autopairs.rule")
local npairs = require("nvim-autopairs")
local cond = require("nvim-autopairs.conds") -- 引入条件模块
npairs.setup({
	disable_filetype = { "TelescopePrompt" },
	disable_in_macro = true,
	disable_in_visualblock = true,
	check_ts = true,
})
npairs.add_rule(Rule("“", "”", "markdown"))
npairs.add_rule(Rule("‘", "’", "markdown"))
npairs.add_rule(Rule("$", "$", "markdown"))
npairs.add_rule(Rule("$$", "$$", "tex"))
npairs.add_rule(Rule("/*", " */", {
	"java",
	"c",
	"cpp",
	"c",
	"cs",
	"javascript",
	"typescript",
	"php",
	"sql",
	"swift",
	"go",
	"rust",
	"kotlin",
	"scala",
	"objc",
	"dart",
	"julia",
	"haskell",
	"perl",
	"r",
	"matlab",
}))
