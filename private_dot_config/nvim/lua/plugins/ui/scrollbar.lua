return {
	-- nvim-scrollbar --
	-- scroller
	-- 滑动条
	{
		"petertriho/nvim-scrollbar",
		dependencies = {
			"lewis6991/gitsigns.nvim",
			{
				"kevinhwang91/nvim-hlslens",
				config = function()
					require("hlslens").setup({
						build_position_cb = function(plist, _, _, _)
							require("scrollbar.handlers.search").handler.show(plist.start_pos)
						end,
					})

					vim.cmd([[
						augroup scrollbar_search_hide
							autocmd!
							autocmd CmdlineLeave : lua require('scrollbar.handlers.search').handler.hide()
						augroup END
					]])
				end,
			},
		},
		config = function()
			require("config.ui.scrollbar")
		end,
	},
}
