require("toggleterm").setup({
	start_in_insert = true,
	-- direction = "float",
	direction = "horizontal",
	open_mapping = [[<C-t>]],
	float_opts = {
		width = function()
			return math.floor(vim.o.columns * 1)
		end,
		height = function()
			return math.floor(vim.o.lines * 0.3)
		end,
		row = function()
			return vim.o.lines - math.floor(vim.o.lines * 0.3) - 3
		end,
		col = 0,
		border = "curved",
		winblend = 20,
	},
	highlights = {
		Normal = {
			link = "Normal",
		},
		WinBar = {
			link = "WinBar",
		},
		WinBarNC = {
			link = "WinBarNC",
		},
		WinBarActive = {
			link = "markdownH4",
		},
		WinBarInactive = {
			link = "markdownBold",
		},
	},
	winbar = {
		enabled = true,
		name_formatter = function(term)
			return string.format("%d:%s", term.id, term.name:match("^(.-);") or term.name)
		end,
	},
})
