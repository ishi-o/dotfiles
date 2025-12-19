require("edgy").setup({
	left = {
		-- {
		-- 	title = "explorer",
		-- 	ft = "snacks_layout_box",
		-- 	filter = function() end,
		-- 	size = { width = 0.3 },
		-- },
		{ title = "outline", ft = "aerial", size = { width = 0.3 } },
	},
	bottom = {
		{
			ft = "toggleterm",
			size = { height = 0.4 },
		},
		{
			ft = "snacks_terminal",
			size = { height = 0.4 },
		},
		{
			ft = "trouble",
			title = "Trouble",
			size = {
				height = 0.4,
			},
		},
		{
			ft = "qf",
			title = "QuickFix",
			size = { height = 0.4 },
		},
		{
			ft = "help",
			size = { height = 0.4 },
			-- only show help buffers
			filter = function(buf)
				return vim.bo[buf].buftype == "help"
			end,
		},
		{
			ft = "spectre_panel",
			size = { height = 0.4 },
		},
		{
			ft = "grug-far",
			size = { height = 0.4 },
		},
	},
	right = {},
	keys = {
		-- close window
		["q"] = function(win)
			win:close()
		end,
		-- hide window
		["<C-q>"] = function(win)
			win:hide()
		end,
		-- close sidebar
		["Q"] = function(win)
			win.view.edgebar:close()
		end,
		-- next open window
		["<Tab>"] = function(win)
			win:next({ visible = true, focus = true })
		end,
		-- previous open window
		["<S-Tab>"] = function(win)
			win:prev({ visible = true, focus = true })
		end,
		-- next loaded window
		["<C-Tab>"] = function(win)
			win:next({ pinned = false, focus = true })
		end,
		-- prev loaded window
		["<C-S-Tab>"] = function(win)
			win:prev({ pinned = false, focus = true })
		end,
		-- increase width
		["<A-l>"] = function(win)
			win:resize("width", 2)
		end,
		-- decrease width
		["<A-h>"] = function(win)
			win:resize("width", -2)
		end,
		-- increase height
		["<A-k>"] = function(win)
			win:resize("height", 2)
		end,
		-- decrease height
		["<A-j>"] = function(win)
			win:resize("height", -2)
		end,
		-- reset all custom sizing
		["<A-r>"] = function(win)
			win.view.edgebar:equalize()
		end,
	},
})
