-- configuration
require("nvim-treesitter-textobjects").setup({
	select = {
		lookahead = true,
		selection_modes = {
			["@parameter.outer"] = "v",
			["@function.outer"] = "V",
			["@class.outer"] = "<c-v>",
		},
		include_surrounding_whitespace = false,
	},
	move = {
		set_jumps = true,
	},
})
