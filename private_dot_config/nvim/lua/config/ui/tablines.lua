require("bufferline").setup({
	options = {
		hover = {
			enabled = true,
			delay = 200,
		},

		offsets = {
			{
				filetype = "neo-tree",
				text = "Directory",
				highlight = "Directory",
				separator = true,
			},
		},

		diagnostics = "nvim_lsp",
		diagnostics_indicator = function(count, level, diagnostics_dict, context)
			local icon = level:match("error") and " " or " "
			return icon .. count
		end,

		show_buffer_close_icons = true,
		show_close_icon = true,
		separator_style = "slant",

		-- close_command = "bdelete! %d",
		-- right_mouse_command = "bdelete! %d",
		-- middle_mouse_command = nil,
	},
})
