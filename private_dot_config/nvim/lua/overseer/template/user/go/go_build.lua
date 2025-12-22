return {
	name = "Build",
	builder = function()
		return {
			cmd = "go",
			args = { "build" },
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
