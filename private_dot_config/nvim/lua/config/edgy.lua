vim.opt.laststatus = 3
vim.opt.splitkeep = "screen"

require("edgy").setup({
	left = {
		{ title = "explorer", ft = "snacks_picker_list", size = { width = 0.3 } },
		{ title = "explorer_input", ft = "snacks_picker_input", size = { width = 0.3 } },
		{ title = "outline", ft = "aerial", size = { width = 0.3 } },
	},
	bottom = {},
	right = {},
})
