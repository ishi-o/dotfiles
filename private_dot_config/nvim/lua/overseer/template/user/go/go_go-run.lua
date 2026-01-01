return {
	name = "Go run",
	builder = function()
		return {
			cmd = "go",
			args = { "run", vim.fn.expand(".") },
			components = {
				"on_complete_notify",
				"default",
			},
		}
	end,
	condition = {
		filetype = { "go" },
	},
}
