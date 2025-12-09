vim.g.bullets_enabled_file_types = {
	"markdown",
	"text",
	"gitcommit",
	"scratch",
}

vim.g.skip_default_snippet_tab = true
vim.g.bullets_set_mappings = 0
vim.cmd("BulletsModeOn")
require("which-key").add({
	{
		group = "markdown autolist",

		{ "<Tab>", "<cmd>call bullets#tab()<CR>", mode = "i", desc = "Tab markdown indent" },
		{ "<S-Tab>", "<cmd>call bullets#un_tab()<CR>", mode = "i", desc = "Shift Tab markdown indent" },
		{ "<CR>", "<CR><cmd>call bullets#new_bullet()<CR>", mode = "i", desc = "New line with bullet" },
		{ "o", "o<cmd>call bullets#new_bullet()<CR>", desc = "New line with bullet" },
		{ "O", "O<cmd>call bullets#new_bullet()<CR>", desc = "New line with bullet" },
		{ "<CR>", "<cmd>call bullets#toggle_checkbox()<CR><CR>", desc = "New line with bullet" },
		{ "<C-r>", "<cmd>call bullets#renumber()<CR>", desc = "Recalculate markdown list nbr" },

		{ "<leader>cn", "<cmd>call bullets#cycle_next()<CR>", desc = "Cycle next list type" },
		{ "<leader>cp", "<cmd>call bullets#cycle_prev()<CR>", desc = "Cycle prev list type" },

		{ ">>", ">><cmd>call bullets#renumber()<CR>", desc = "Recalculate list nbr when >>" },
		{ "<<", "<<<cmd>call bullets#renumber()<CR>", desc = "Recalculate list nbr when <<" },
		{ "dd", "dd<cmd>call bullets#renumber()<CR>", desc = "Recalculate list nbr when dd" },
		{ "d", "d<cmd>call bullets#renumber()<CR>", mode = "v", desc = "Recalculate list nbr when d" },
	},
})
