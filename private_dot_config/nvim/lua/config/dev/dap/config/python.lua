local dap = require("dap")

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
