local ok, claudecode = pcall(require, "claudecode")
if not ok then
	return
end

claudecode.setup({
	-- Terminal configuration
	terminal = {
		side = "right", -- Position: "left", "right", "top", "bottom"
		width = 0.45, -- Width ratio for side terminals
		height = 0.5, -- Height ratio for top/bottom terminals
	},

	-- Command configuration
	command = "claude", -- Claude Code CLI command
	-- You can also specify full path: "/path/to/claude"

	-- Keymaps (set to false to disable)
	keymaps = {
		toggle = {
			normal = "<leader>aa", -- Toggle Claude Code terminal
			terminal = "<C-aa>", -- Toggle from terminal mode
		},
		send = {
			normal = "<leader>as", -- Send current line or selection
			visual = "<leader>as", -- Send visual selection
		},
		diff = {
			accept = "<leader>ad", -- Accept diff
			reject = "<leader>ar", -- Reject diff
		},
	},

	-- Auto-focus terminal when opened
	auto_focus = true,

	-- Close terminal on exit
	close_on_exit = false,

	-- Highlight group for terminal
	highlights = {
		terminal = "ClaudeCodeTerminal",
	},

	-- Log level: "trace", "debug", "info", "warn", "error"
	log_level = "info",
})

-- Set up highlights
vim.api.nvim_set_hl(0, "ClaudeCodeTerminal", { link = "NormalFloat" })
