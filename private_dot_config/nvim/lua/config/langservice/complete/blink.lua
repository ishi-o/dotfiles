local blink = require("blink.cmp")
blink.setup({
	keymap = {
		preset = "none",
		["<C-Space>"] = {
			"hide",
			"show",
		},
		["<Tab>"] = {
			"accept",
			"fallback",
		},
		["<Enter>"] = {
			"snippet_forward",
			"fallback",
		},
		["<A-k>"] = { "select_prev", "fallback" },
		["<A-j>"] = { "select_next", "fallback" },
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
		ghost_text = {
			enabled = true,
		},
		accept = {
			auto_brackets = {
				override_brackets_for_filetypes = {
					markdown = { "", "" },
				},
			},
		},
	},
	sources = {
		default = {
			"lazydev",
			"lsp",
			"path",
			"snippets",
			"buffer",
		},
		providers = {
			lazydev = {
				name = "LazyDev",
				module = "lazydev.integrations.blink",
				score_offset = 100,
			},
		},
	},
	fuzzy = { implementation = "lua" },
	cmdline = {
		enabled = true,
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
	-- snippets = { preset = "luasnip" },
})
