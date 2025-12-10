local dap = require("dap")

dap.configurations.cpp = {
	{
		type = "codelldb",
		name = "C/Cpp Debug",
		request = "launch",
		program = function()
			local function needs_recompile(source, output)
				if vim.fn.filereadable(output) == 0 then
					return true
				end
				local source_mtime = vim.fn.getftime(source)
				local output_mtime = vim.fn.getftime(output)
				return source_mtime > output_mtime
			end
			local source = vim.fn.expand("%:p")
			local file_stem = vim.fn.expand("%:t:r")
			local output_dir = "./build/"
			local output = output_dir .. file_stem
			vim.fn.mkdir(output_dir, "p")
			if needs_recompile(source, output) then
				os.execute('g++ -g "' .. source .. '" -o "' .. output .. '"')
			end
			return output
		end,
		cwd = "${workspaceFolder}",
	},
}

dap.configurations.c = dap.configurations.cpp

dap.adapters.codelldb = {
	type = "server",
	port = "${port}",
	executable = {
		command = "codelldb",
		args = {
			"--port",
			"${port}",
		},
	},
}
