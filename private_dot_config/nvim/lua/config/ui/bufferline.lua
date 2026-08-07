local bufferline = require("bufferline")
local bufferline_config = require("bufferline.config")

bufferline.setup({
	options = {
		custom_filter = function(buf)
			local buffers = vim.t.bufferline_buffers
			return bufferline_config.options.mode ~= "buffers"
				or not buffers
				or buffers[tostring(buf)] == true
		end,
		hover = {
			enabled = true,
			reveal = { "close" },
		},

		indicator = { icon = "▌" },

		offsets = {
			{
				filetype = "neo-tree",
				text = "Directory",
				highlight = "Directory",
				separator = true,
			},
		},

		diagnostics = "nvim_lsp",
		diagnostics_indicator = function(count, level)
			local icon = level:match("error") and " " or " "
			return icon .. count
		end,

		separator_style = "thick",
	},
})
