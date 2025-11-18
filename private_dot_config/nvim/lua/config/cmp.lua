local cmp = require("cmp")

cmp.setup({
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "buffer" },
		{ name = "path" },
	}),

	mapping = {
		-- open cmp
		-- ["<C-S-c>"] = cmp.mapping.complete(),
		-- close cmp
		-- ["<C-S-c>"] = cmp.mapping.abort(),

		-- confirm cmp
		["<Tab>"] = cmp.mapping.confirm({ select = true }),

		-- previous or next cmp item
		["<C-k>"] = cmp.mapping.select_prev_item(),
		["<C-j>"] = cmp.mapping.select_next_item(),
	},
})
