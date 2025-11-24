return {
	name = "Run Python",
	builder = function()
		return {
			cmd = "python",
			args = { vim.fn.expand("%:p") },
			components = {
				"open_output",
				"default",
			},
		}
	end,
	condition = {
		filetype = { "python" },
	},
}
