return {
	{
		cond = function()
			return _G.plugin_installed("trouble.nvim")
		end,
		{ "<leader>o", "<cmd>Trouble symbols toggle focus=false<CR>", desc = "Toggle: outline (Symbols)" },
		{
			"[s",
			function()
				require("trouble").prev({ mode = "symbols", skip_groups = true, jump = true })
			end,
			desc = "Goto: prev symbol",
		},
		{
			"]s",
			function()
				require("trouble").next({ mode = "symbols", skip_groups = true, jump = true })
			end,
			desc = "Goto: next symbol",
		},
		{
			"]S",
			function()
				require("trouble").prev({ mode = "symbols", skip_groups = true, jump = true })
			end,
			desc = "Goto: prev symbol",
		},
		{
			"[S",
			function()
				require("trouble").next({ mode = "symbols", skip_groups = true, jump = true })
			end,
			desc = "Goto: next symbol",
		},
		{
			"(",
			function()
				require("trouble").prev({ mode = "symbols", skip_groups = true, jump = true })
			end,
			desc = "Goto: prev symbol",
		},
		{
			")",
			function()
				require("trouble").next({ mode = "symbols", skip_groups = true, jump = true })
			end,
			desc = "Goto: next symbol",
		},
	},
	{
		cond = function()
			return _G.plugin_installed("trouble.nvim")
		end,
		"<leader>xs",
		"<cmd>Trouble symbols toggle focus=false<CR>",
		desc = "Toggle: symbols (Trouble)",
	},
}
