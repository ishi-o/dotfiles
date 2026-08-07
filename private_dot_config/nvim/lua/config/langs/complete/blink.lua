local blink = require("blink.cmp")
local has_friendly_snippets = #vim.api.nvim_get_runtime_file("snippets/global.json", false) > 0

blink.setup({
	keymap = {
		preset = "none",
		["<C-y>"] = {
			"hide",
			"show",
		},
		["<Tab>"] = {
			"accept",
			"fallback",
		},
		-- ["<Enter>"] = {
		-- 	"snippet_forward",
		-- 	"fallback",
		-- },
		["<C-n>"] = {
			"snippet_forward",
			"fallback",
		},
		["<C-p>"] = {
			"snippet_backward",
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
	signature = {
		enabled = true,
		window = {
			border = "single",
			winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder",
		},
	},
	sources = {
		default = function()
			local sources = {
				"lazydev",
				"lsp",
				"path",
				"snippets",
				"buffer",
			}
			if pcall(require, "vim_dadbod_completion.blink") then
				table.insert(sources, "dadbod")
			end
			if pcall(require, "nvim-mybatis.completion.blink") then
				table.insert(sources, "mybatis")
			end
			return sources
		end,
		providers = {
			lazydev = {
				name = "LazyDev",
				module = "lazydev.integrations.blink",
				score_offset = 100,
			},
			dadbod = {
				name = "Dadbod",
				module = "vim_dadbod_completion.blink",
			},
			mybatis = {
				name = "Mybatis",
				module = "nvim-mybatis.completion.blink",
			},
			snippets = {
				opts = {
					friendly_snippets = has_friendly_snippets,
					extended_filetypes = has_friendly_snippets and {
						cpp = { "unreal" },
						markdown = { "tex", "jekyll" },
						mysql = { "sql" },
						pgsql = { "sql" },
						plsql = { "sql" },
					} or {},
				},
			},
		},
	},
	snippets = { preset = "default" },
	-- snippets = { preset = "luasnip" },
	fuzzy = { implementation = "lua" },
	cmdline = {
		enabled = true,
		keymap = {
			-- preset = "inherit",
			preset = "none",
			["<S-Tab>"] = { "select_prev", "fallback" },
			["<Tab>"] = { "show", "select_next", "fallback" },
			["<C-y>"] = {
				"hide",
				"show",
			},
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
})
