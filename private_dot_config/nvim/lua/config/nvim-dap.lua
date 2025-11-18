local dap = require("dap")

dap.adapters.java = {
	type = "executable",
	command = "java",
	args = {},
}

dap.configurations.java = {
	{
		type = "java",
		request = "launch",
		name = "Launch Current File",
		mainClass = "${file}",
		projectName = "${workspaceFolder}",
		console = "integratedTerminal",
	},

	{
		type = "java",
		request = "launch",
		name = "Launch Main Class",
		mainClass = function()
			return vim.fn.input("Main class: ", "", "file")
		end,
		projectName = "${workspaceFolder}",
		console = "integratedTerminal",
	},

	{
		type = "java",
		request = "attach",
		name = "Attach to Remote",
		hostName = function()
			return vim.fn.input("Host: ", "localhost")
		end,
		port = function()
			return tonumber(vim.fn.input("Port: ", "5005"))
		end,
		projectName = "${workspaceFolder}",
	},
}

vim.keymap.set("n", "<F6>", function() require("dap").continue() end, { desc = "Debug: Start/Continue" })
vim.keymap.set("n", "<F10>", function() require("dap").step_over() end, { desc = "Debug: Step Over" })
vim.keymap.set("n", "<F11>", function() require("dap").step_into() end, { desc = "Debug: Step Into" })
vim.keymap.set("n", "<F12>", function() require("dap").step_out() end, { desc = "Debug: Step Out" })
vim.keymap.set("n", "<leader>db", function() require("dap").toggle_breakpoint() end, { desc = "Debug: Toggle Breakpoint" })
vim.keymap.set("n", "<leader>dB", function() 
	require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "Debug: Set Conditional Breakpoint" })
vim.keymap.set("n", "<leader>dr", function() require("dap").repl.open() end, { desc = "Debug: Open REPL" })
vim.keymap.set("n", "<leader>dl", function() require("dap").run_last() end, { desc = "Debug: Run Last" })
