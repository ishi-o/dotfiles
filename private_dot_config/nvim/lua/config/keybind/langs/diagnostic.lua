return {
	{
		{
			"gk",
			function()
				vim.diagnostic.open_float({ focus = true, focus_id = "diagnostic_popup" })
			end,
			desc = "Show: diagnostic (float)",
		},
		{
			"[e",
			function()
				vim.diagnostic.jump({ count = -vim.v.count1, severity = vim.diagnostic.severity.ERROR })
			end,
			desc = "Goto: prev error",
		},
		{
			"]e",
			function()
				vim.diagnostic.jump({ count = vim.v.count1, severity = vim.diagnostic.severity.ERROR })
			end,
			desc = "Goto: next error",
		},
		{
			"[w",
			function()
				vim.diagnostic.jump({ count = -vim.v.count1, severity = vim.diagnostic.severity.WARN })
			end,
			desc = "Goto: prev warning",
		},
		{
			"]w",
			function()
				vim.diagnostic.jump({ count = vim.v.count1, severity = vim.diagnostic.severity.WARN })
			end,
			desc = "Goto: next warning",
		},
		{ "[d", desc = "Goto: prev diagnostic" },
		{ "]d", desc = "Goto: next diagnostic" },
		{ "]D", desc = "Goto: prev diagnostic" },
		{ "[D", desc = "Goto: next diagnostic" },
		{ "[l", desc = "Goto: prev location" },
		{ "]l", desc = "Goto: next location" },
		{ "]L", desc = "Goto: prev location" },
		{ "[L", desc = "Goto: next location" },
		{ "[q", desc = "Goto: prev quickfix" },
		{ "]q", desc = "Goto: next quickfix" },
		{ "]Q", desc = "Goto: prev quickfix" },
		{ "[Q", desc = "Goto: next quickfix" },
		{ "gQ", vim.diagnostic.setqflist, desc = "Show: qflist" },
		{ "gL", vim.diagnostic.setloclist, desc = "Show: loclist" },
	},
	{
		cond = function()
			return _G.plugin_installed("trouble.nvim")
		end,
		{ "<leader>xx", "<cmd>Trouble diagnostics toggle<CR>", desc = "Show: global diagnostics (trouble)" },
		{
			"<leader>xX",
			"<cmd>Trouble diagnostics toggle filter.buf=0<CR>",
			desc = "Toggle: buffer diagnostics (trouble)",
		},
		{
			"<leader>xl",
			"<cmd>Trouble lsp toggle focus=false win.position=right<CR>",
			desc = "Toggle: lsp (trouble)",
		},
		{ "<leader>xQ", "<cmd>Trouble qflist toggle<CR>", desc = "Toggle: qflist (trouble)" },
		{ "<leader>xL", "<cmd>Trouble loclist toggle<CR>", desc = "Toggle: loclist (trouble)" },
	},
}
