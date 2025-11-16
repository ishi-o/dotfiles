local npairs = require('nvim-autopairs')
npairs.setup({
	disable_filetype = { "TelescopePrompt" },
	disable_in_macro = true,
	disable_in_visualblock = true,
	check_ts = true,
})
