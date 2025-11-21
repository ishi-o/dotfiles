require("dapui").setup({
	layouts = {
		{
			elements = {
				-- "scopes",
				"stacks",
				"breakpoints",
				"watches",
			},
			size = 40,
			position = "left",
		},
		{
			elements = {
				-- "console",
				"repl",
			},
			size = 0.25,
			position = "bottom",
		},
	},
})

require("dap")
require("nvim-dap-virtual-text").setup({
	enabled = true,
	show_stop_reason = true,
	commented = false,
})
local dap = require("dap")
local dapui = require("dapui")

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
	{
		type = "go",
		name = "Debug (Attach)",
		request = "attach",
		mode = "local",
		processId = require("dap.utils").pick_process,
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
