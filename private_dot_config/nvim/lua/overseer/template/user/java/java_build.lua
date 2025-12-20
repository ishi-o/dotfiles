return {
	name = "Build",
	builder = function()
		return {
			cmd = { "mvn", "compile" },
			components = { "on_complete_notify", "default" },
		}
	end,
	condition = {
		filetype = { "java" },
		callback = function()
			local dir = vim.fn.expand("%:p:h")
			return vim.fn.filereadable(dir .. "/pom.xml") == 1
		end,
	},
}
