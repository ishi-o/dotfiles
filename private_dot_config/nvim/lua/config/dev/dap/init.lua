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

require("persistent-breakpoints").setup()
vim.api.nvim_create_autocmd({ "BufReadPost" }, {
	callback = require("persistent-breakpoints.api").load_breakpoints,
})

require("config.dev.dap.config.c-cpp")
require("config.dev.dap.config.go")
require("config.dev.dap.config.java")
require("config.dev.dap.config.python")
