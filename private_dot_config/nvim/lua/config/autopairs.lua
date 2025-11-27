local Rule = require("nvim-autopairs.rule")
local npairs = require("nvim-autopairs")
npairs.setup({
	disable_filetype = { "TelescopePrompt" },
	disable_in_macro = true,
	disable_in_visualblock = true,
	check_ts = true,
})
npairs.add_rule(Rule("$", "$", "markdown"))
npairs.add_rule(Rule("$$", "$$", "tex"))
