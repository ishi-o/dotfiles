return {
	{
		cond = function()
			return _G.plugin_installed("grug-far.nvim")
		end,
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
	{
		cond = function()
			return _G.plugin_installed("substitute.nvim")
		end,
		{ "mp", '<cmd>lua require("substitute").operator()<CR>', desc = "Substitute in operator mode" },
		{ "mpp", '<cmd>lua require("substitute").line()<CR>', desc = "Substitute curr line" },
		{ "mP", '<cmd>lua require("substitute").eol()<CR>', desc = "Substitute to eol" },
		{ "mp", '<cmd>lua require("substitute").visual()<CR>', mode = "x", desc = "Substitute in visual mode" },
	},
}
