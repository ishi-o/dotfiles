return {
	name = "Run Go",
	builder = function()
		return {
			cmd = "go",
			args = { "run", vim.fn.expand("%:p") },
			components = {
				"open_output",
				"default",
			},
		}
	end,
	condition = {
		filetype = { "go" },
	},
}
