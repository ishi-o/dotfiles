vim.keymap.set("n", "<F5>", function()
	vim.cmd("w")

	local command = "python " .. vim.fn.expand("%")
	local Terminal = require("toggleterm.terminal").Terminal
	local py_term = Terminal:new({
		cmd = command,
		close_on_exit = false,
		direction = "float",
	})
	py_term:toggle()
end, { buffer = true, desc = "Run Python" })
