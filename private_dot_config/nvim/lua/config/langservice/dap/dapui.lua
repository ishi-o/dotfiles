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
