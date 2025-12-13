require("copilot").setup({
	suggestion = {
		enabled = true,
		hide_during_completion = false,
		auto_trigger = true,
		keymap = {
			accept = false,
			next = "<A-j>",
			prev = "<A-k>",
		},
	},
	panel = { enabled = false },
	filetypes = {
		AvanteInput = false,
		["dap-repl"] = false,
		help = true,
		markdown = true,
		snacks_picker_input = false,
		TelescopePrompt = false,
	},
})
