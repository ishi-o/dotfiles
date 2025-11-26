local dap = require("dap")
local dapui = require("dapui")

dapui.setup({
	layouts = {
		{
			elements = {
				-- "scopes",
				"stacks",
				"breakpoints",
				"watches",
			},
			size = 0.3,
			position = "right",
		},
		{
			elements = {
				"console",
				"repl",
			},
			size = 0.25,
			position = "bottom",
		},
	},
})

require("nvim-dap-virtual-text").setup({
	enabled = true,
	show_stop_reason = true,
	commented = false,
})

-- dap.defaults.fallback.terminal_win_cmd = "tabnew"

dap.listeners.before.attach.dapui_config = function()
	dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
	dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
	dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
	dapui.close()
end

dap.configurations.go = {
	{
		type = "go",
		name = "Debug (File)",
		request = "launch",
		program = "${file}",
		outputMode = "remote",
	},
	{
		type = "go",
		name = "Debug (Package)",
		request = "launch",
		program = "./${relativeFileDirname}",
		outputMode = "remote",
	},
	{
		type = "go",
		name = "Debug (Test)",
		request = "launch",
		mode = "test",
		program = "${file}",
		outputMode = "remote",
	},
}

dap.adapters.go = {
	type = "server",
	port = "${port}",
	executable = {
		command = "dlv",
		args = { "dap", "-l", "127.0.0.1:${port}" },
	},
}

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
		args = {},
		stopOnEntry = false,
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

dap.configurations.python = {
	{
		type = "python",
		request = "launch",
		name = "Debug File",
		program = "${file}",
		console = "integratedTerminal",
	},
}

dap.adapters.python = {
	type = "executable",
	command = "python",
	args = {
		"-m",
		"debugpy.adapter",
	},
}

require("persistent-breakpoints").setup()
vim.api.nvim_create_autocmd({ "BufReadPost" }, {
	callback = require("persistent-breakpoints.api").load_breakpoints,
})

vim.keymap.set("n", "<F6>", require("dap").continue, { desc = "Debug: Continue" })
vim.keymap.set("n", "<F7>", require("dap").step_over, { desc = "Debug: Step Over" })
vim.keymap.set("n", "<F8>", require("dap").step_into, { desc = "Debug: Step Into" })
-- vim.keymap.set("n", "<F9>", require("dap").toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
vim.keymap.set(
	"n",
	"<F9>",
	"<cmd>lua require('persistent-breakpoints.api').toggle_breakpoint()<CR>",
	{ desc = "Debug: Toggle Breakpoint" }
)
