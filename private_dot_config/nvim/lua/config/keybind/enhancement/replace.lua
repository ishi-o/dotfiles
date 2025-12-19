-- replace --
return {
	-- grup-far --
	{
		{
			"<leader>ss",
			function()
				local grug = require("grug-far")
				local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
				grug.open({
					transient = true,
					prefills = {
						filesFilter = ext and ext ~= "" and "*." .. ext or nil,
					},
				})
			end,
			mode = { "n", "x" },
			desc = "Search and Replace",
		},
	},

	-- substitute --
	{
		{ "zp", '<cmd>lua require("substitute").operator()<CR>', desc = "Substitute in operator mode" },
		{ "zpp", '<cmd>lua require("substitute").line()<CR>', desc = "Substitute curr line" },
		{ "zP", '<cmd>lua require("substitute").eol()<CR>', desc = "Substitute to eol" },
		{ "zp", '<cmd>lua require("substitute").visual()<CR>', mode = "x", desc = "Substitute in visual mode" },
	},

	-- spectre --
	-- {
	-- { "<leader>ss", '<cmd>lua require("spectre").toggle()<CR>', desc = "Toggle: Spectre" },
	-- {
	-- 	"<leader>sw",
	-- 	'<cmd>lua require("spectre").open_visual({select_word=true})<CR>',
	-- 	desc = "Search current word",
	-- },
	-- { "<leader>sw", '<esc><cmd>lua require("spectre").open_visual()<CR>', desc = "Search current word" },
	-- {
	-- 	"<leader>sp",
	-- 	'<cmd>lua require("spectre").open_file_search({select_word=true})<CR>',
	-- 	desc = "Search on current file",
	-- },
	-- },
}
