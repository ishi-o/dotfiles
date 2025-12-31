return {
	name = "Go tidy",
	builder = function()
		return {
			cmd = "go",
			args = { "mod", "tidy" },
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
