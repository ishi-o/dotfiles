local cmp = require("cmp")
local lspkind = require("lspkind")

local source_mapping = {
	buffer = "[Buffer]",
	nvim_lsp = "[LSP]",
	nvim_lua = "[Lua]",
	cmp_tabnine = "[TN]",
	path = "[Path]",
	luasnip = "[Snippet]",
}

cmp.setup({
	formatting = {
		format = function(entry, vim_item)
			vim_item.kind = lspkind.symbolic(vim_item.kind, { mode = "symbol" })
			local source_name = entry.source.name
			local menu_icon = source_mapping[source_name] or "[" .. source_name .. "]"
			vim_item.menu = menu_icon
			return vim_item
		end,
	},

	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "buffer" },
		{ name = "path" },
	}),

	mapping = {
		-- confirm cmp
		["<Tab>"] = cmp.mapping.confirm({ select = true }),

		-- previous or next cmp item
		["<A-k>"] = cmp.mapping.select_prev_item(),
		["<A-j>"] = cmp.mapping.select_next_item(),
	},
})
