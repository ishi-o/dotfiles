require("bufferline").setup({
	highlights = {
		buffer_selected = { underline = true, bold = true, italic = true },
		indicator_selected = { underline = true },

		tab_selected = { underline = true },
		tab_separator_selected = { underline = true },
		close_button_selected = { underline = true },
		numbers_selected = { underline = true, bold = true, italic = true },
		diagnostic_selected = { underline = true, bold = true, italic = true },
		hint_selected = { underline = true, bold = true, italic = true },
		hint_diagnostic_selected = { underline = true, bold = true, italic = true },
		info_selected = { underline = true, bold = true, italic = true },
		info_diagnostic_selected = { underline = true, bold = true, italic = true },
		warning_selected = { underline = true, bold = true, italic = true },
		warning_diagnostic_selected = { underline = true, bold = true, italic = true },
		error_selected = { underline = true, bold = true, italic = true },
		error_diagnostic_selected = { underline = true, bold = true, italic = true },
		modified_selected = { underline = true },
		duplicate_selected = { underline = true, italic = true },
		separator_selected = { underline = true },
		pick_selected = { underline = true, bold = true, italic = true },
	},
	options = {
		hover = {
			enabled = true,
			delay = 200,
			reveal = { "close" },
		},

		indicator = {
			icon = "▌",
			-- style = "underline",
		},

		offsets = {
			{
				filetype = "neo-tree",
				text = "Directory",
				highlight = "Directory",
				separator = true,
			},
			{
				filetype = "snacks_layout_box",
				-- text = "Explorer",
				-- highlight = "Directory",
				-- separator = true,
			},
		},

		diagnostics = "nvim_lsp",
		diagnostics_indicator = function(count, level, diagnostics_dict, context)
			local icon = level:match("error") and " " or " "
			return icon .. count
		end,

		show_buffer_close_icons = true,
		show_close_icon = true,
		-- separator_style = "slant",
		-- separator_style = "slope",
		separator_style = "thick",
		-- separator_style = "thin",

		-- close_command = "bdelete! %d",
		-- right_mouse_command = "bdelete! %d",
		-- middle_mouse_command = nil,
	},
})
