require("csvview").setup({
	parser = { comments = { "#", "//" } },
	keymaps = {
		textobject_field_inner = { "if", mode = { "o", "x" } },
		textobject_field_outer = { "af", mode = { "o", "x" } },
		jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
		jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
		jump_next_row = { "<Enter>", mode = { "n", "v" } },
		jump_prev_row = { "<S-Enter>", mode = { "n", "v" } },
	},
})

vim.api.nvim_create_autocmd("BufRead", {
	pattern = "*.csv",
	callback = function()
		vim.cmd("CsvViewEnable display_mode=border header_lnum=1")
	end,
	desc = "Preprocess Csv File",
})
