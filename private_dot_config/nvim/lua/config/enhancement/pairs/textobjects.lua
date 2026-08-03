local ok, treesitter_textobjects = pcall(require, "nvim-treesitter-textobjects")
if ok then
	treesitter_textobjects.setup({
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
end
