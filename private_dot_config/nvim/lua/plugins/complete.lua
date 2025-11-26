return {
	-- complete
	{
		"saghen/blink.cmp",
		version = "1.*",
		-- optional = true,
		dependencies = {
			"rafamadriz/friendly-snippets",
			"onsails/lspkind.nvim",
			{
				"saghen/blink.compat",
				opts = {},
				version = not vim.g.lazyvim_blink_main and "*",
			},
		},
		config = function()
			require("config.complete.blink")
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		optional = true,
		enabled = false,
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"onsails/lspkind.nvim",
		},
		config = function()
			require("config.complete.nvimcmp")
		end,
	},
	{
		"L3MON4D3/LuaSnip",
		optional = true,
		dependencies = {
			"rafamadriz/friendly-snippets",
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			require("config.complete.luasnip")
		end,
	},
	{
		"neoclide/coc.nvim",
		branch = "release",
		build = "npm install --frozen-lockfile",
		optional = true,
		config = function()
			vim.g.coc_global_extensions = {
				"coc-java",
				-- "coc-json",
				-- "coc-tsserver",
				-- "coc-pyright",
				-- "coc-rust-analyzer",
			}

			vim.keymap.set("n", "gd", "<Plug>(coc-definition)", { silent = true })
			vim.keymap.set("n", "gy", "<Plug>(coc-type-definition)", { silent = true })
			vim.keymap.set("n", "gi", "<Plug>(coc-implementation)", { silent = true })
			vim.keymap.set("n", "gr", "<Plug>(coc-references)", { silent = true })
			vim.keymap.set("n", "K", '<cmd>call CocActionAsync("doHover")<CR>', { silent = true })
			vim.keymap.set("i", "<Tab>", "<cmd>call coc#pum#confirm()<CR>", { desc = "Confirm Complete" })
			vim.keymap.set("i", "<A-k>", "<cmd>call coc#pum#select_prev()<CR>", { desc = "Confirm Complete" })
			vim.keymap.set("i", "<A-j>", "<cmd>call coc#pum#select_next()<CR>", { desc = "Confirm Complete" })
		end,
	},
}
