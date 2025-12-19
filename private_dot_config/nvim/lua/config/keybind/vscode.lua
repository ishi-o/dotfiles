return {
	-- vscode-neovim keybind --
	{ "jj", '<cmd>call VSCodeNotify("<C-c>")<CR>', mode = { "i", "c" }, desc = "Return to normal mode" },
	{ "<leader>s", '<cmd>call VSCodeNotify("workbench.action.files.save")<CR>', desc = "Save file" },
	{ "<leader>z", '<cmd>call VSCodeNotify("workbench.action.quit")<CR>', desc = "Quit neovim" },
	{
		"<leader>q",
		'<cmd>call VSCodeNotify("workbench.action.closeActiveEditor")<CR>',
		desc = "Close file",
	},

	{ "<leader>t", ":edit<Space>", desc = "New buffer (input filename)" },
	{ "<leader>T", ":tabnew<Space>", desc = "New tab (input filename)" },
	{
		"<leader>B",
		'<cmd>call VSCodeNotify("workbench.action.previousEditor")<CR>',
		desc = "Previous tab",
	},
	{ "<leader>N", '<cmd>call VSCodeNotify("workbench.action.nextEditor")<CR>', desc = "Next tab" },
	{
		"<leader>b",
		'<cmd>call VSCodeNotify("workbench.action.previousEditor")<CR>',
		desc = "Previous buffer",
	},
	{ "<leader>n", '<cmd>call VSCodeNotify("workbench.action.nextEditor")<CR>', desc = "Next buffer" },

	{
		"<A-j>",
		'<cmd>call VSCodeNotify("editor.action.moveLinesDownAction")<CR>',
		desc = "Move line down",
	},
	{ "<A-k>", '<cmd>call VSCodeNotify("editor.action.moveLinesUpAction")<CR>', desc = "Move line up" },

	{ "<leader>p", ":split<Space>", desc = "Horizontal split (input filename)" },
	{ "<leader>v", ":vsplit<Space>", desc = "Vertical split (input filename)" },

	{
		"<leader>h",
		'<cmd>call VSCodeNotify("workbench.action.focusLeftGroup")<CR>',
		desc = "Focus left window",
	},
	{
		"<leader>j",
		'<cmd>call VSCodeNotify("workbench.action.focusBelowGroup")<CR>',
		desc = "Focus below window",
	},
	{
		"<leader>k",
		'<cmd>call VSCodeNotify("workbench.action.focusAboveGroup")<CR>',
		desc = "Focus above window",
	},
	{
		"<leader>l",
		'<cmd>call VSCodeNotify("workbench.action.focusRightGroup")<CR>',
		desc = "Focus right window",
	},

	{
		"<C-c>",
		'<cmd>call VSCodeNotify("editor.action.clipboardCopyAction")<CR>',
		mode = "x",
		desc = "Copy selection",
	},
	{
		"<C-c>",
		'<cmd>call VSCodeNotify("editor.action.clipboardCopyAction")<CR>',
		mode = { "n", "i" },
		desc = "Copy line",
	},
}
