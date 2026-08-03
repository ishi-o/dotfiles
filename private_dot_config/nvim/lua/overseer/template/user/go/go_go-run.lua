return {
	name = "Go run",
	builder = function()
		return {
			cmd = "go",
			args = { "run", vim.fn.expand(".") },
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
