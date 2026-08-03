return {
	name = "Air run",
	builder = function()
		return {
			cmd = "air",
			args = {},
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
