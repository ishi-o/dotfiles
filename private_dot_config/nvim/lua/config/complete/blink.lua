local blink = require("blink.cmp")
blink.setup({
	keymap = {
		preset = "none",
		["<Tab>"] = { "accept", "fallback" },
		["<A-k>"] = { "select_prev", "fallback" },
		["<A-j>"] = { "select_next", "fallback" },

		-- ["<Enter>"] = { "accept", "fallback" },
		-- ["<S-Tab>"] = { "select_prev", "fallback" },
		-- ["<Tab>"] = { "select_next", "fallback" },
	},
	appearance = {
		nerd_font_variant = "mono",
	},
	completion = {
		documentation = { auto_show = true, auto_show_delay_ms = 500 },
		list = {
			selection = {
				preselect = true,
				-- auto_insert = false,
			},
		},
	},
	sources = {
		default = {
			"lsp",
			"path",
			"snippets",
			"buffer",
		},
	},
	fuzzy = { implementation = "lua" },
	cmdline = {
		keymap = {
			-- preset = "inherit",
			preset = "none",
			["<S-Tab>"] = { "select_prev", "fallback" },
			["<Tab>"] = { "show", "select_next", "fallback" },
		},
		completion = {
			menu = {
				auto_show = true,
			},
			ghost_text = {
				enabled = true,
			},
			list = {
				selection = {
					preselect = false,
					-- auto_insert = false,
				},
			},
		},
	},
	snippets = { preset = "default" },
})
