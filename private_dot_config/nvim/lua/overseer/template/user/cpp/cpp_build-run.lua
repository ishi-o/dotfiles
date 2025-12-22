return {
	name = "BuildRun",
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
			cmd = "sh",
			args = {
				"-c",
				compiler
					.. " "
					.. vim.fn.shellescape(source_file)
					.. " -o "
					.. vim.fn.shellescape(output_file)
					.. " -g && "
					.. vim.fn.shellescape(output_file),
			},
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
