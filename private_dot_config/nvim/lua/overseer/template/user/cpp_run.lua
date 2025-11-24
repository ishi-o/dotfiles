return {
	name = "Run C/Cpp",
	builder = function()
		local file_name = vim.fn.expand("%:t:r")
		local build_dir = "./build/"
		local output_file = build_dir .. file_name
		return {
			cmd = output_file,
			components = {
				"open_output",
				"default",
			},
		}
	end,
	condition = {
		filetype = { "c", "cpp" },
	},
}
