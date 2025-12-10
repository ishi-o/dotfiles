local dap = require("dap")

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
