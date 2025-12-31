return {
	name = "BuildRun",
	builder = function()
		local has_air = vim.fn.executable("air") == 1
		local cmd = "go"
		local args = { "run", vim.fn.expand(".") }
		if has_air then
			cmd = "air"
			args = {}
		end
		return {
			cmd = cmd,
			args = args,
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
