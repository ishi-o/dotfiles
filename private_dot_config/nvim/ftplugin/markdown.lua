local conf = require("config.dev.lsp.conf")

vim.lsp.config("marksman", {
	on_attach = conf.on_attach,
	capabilities = conf.capabilities,
})

require("which-key").add({
	{
		group = "markdown autolist",

		{ "<Tab>", "<cmd>AutolistTab<CR>", mode = "i", desc = "Tab markdown indent" },
		{ "<S-Tab>", "<cmd>AutolistShiftTab<CR>", mode = "i", desc = "Shift Tab markdown indent" },
		{ "<CR>", "<CR><cmd>AutolistNewBullet<CR>", mode = "i", desc = "New line with bullet" },
		{ "o", "o<cmd>AutolistNewBullet<CR>", desc = "New line with bullet" },
		{ "O", "O<cmd>AutolistNewBulletBefore<CR>", desc = "New line with bullet" },
		{ "<CR>", "<cmd>AutolistToggleCheckbox<CR><CR>", desc = "New line with bullet" },
		{ "<C-r>", "<cmd>AutolistRecalculate<CR>", desc = "Recalculate markdown list nbr" },

		{ "<leader>cn", require("autolist").cycle_next_dr, expr = true },
		{ "<leader>cp", require("autolist").cycle_prev_dr, expr = true },

		{ ">>", ">><cmd>AutolistRecalculate<CR>", desc = "Recalculate list nbr when >>" },
		{ "<<", "<<<cmd>AutolistRecalculate<CR>", desc = "Recalculate list nbr when <<" },
		{ "dd", "dd<cmd>AutolistRecalculate<CR>", desc = "Recalculate list nbr when dd" },
		{ "d", "d<cmd>AutolistRecalculate<CR>", mode = "v", desc = "Recalculate list nbr when d" },
	},
})
