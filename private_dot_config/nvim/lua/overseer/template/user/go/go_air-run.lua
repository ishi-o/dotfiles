return {
	name = "Air run",
	builder = function()
		return {
			cmd = "air",
			args = {},
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
