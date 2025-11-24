return {
	name = "Build C/Cpp",
	builder = function()
		local source_file = vim.fn.expand("%:p")
		local file_name = vim.fn.expand("%:t:r")
		local extension = vim.fn.expand("%:e")
		local compiler = (extension == "c") and "gcc" or "g++"

		local build_dir = "./build/"
		if vim.fn.isdirectory(build_dir) == 0 then
			vim.fn.mkdir(build_dir, "p")
		end

		local output_file = build_dir .. file_name

		return {
			cmd = compiler,
			args = { source_file, "-o", output_file, "-g" },
			components = {
				"on_complete_notify",
				"default",
			},
		}
	end,
	condition = {
		filetype = { "c", "cpp" },
	},
}
