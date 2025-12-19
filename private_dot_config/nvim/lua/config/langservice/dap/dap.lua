local dap = require("dap")
local dapui = require("dapui")

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

local confs = {
	"c-cpp",
	"go",
	"java",
	"python",
}
for _, conf in ipairs(confs) do
	require("config.langservice.dap.config." .. conf)
end
