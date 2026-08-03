return {
	{ "<leader>w", '<cmd>lua require("vscode").call("workbench.action.files.save")<CR>', desc = "Save file" },
	{ "<leader>z", '<cmd>lua require("vscode").call("workbench.action.quit")<CR>', desc = "Quit neovim" },
	{
		"<leader>q",
		'<cmd>lua require("vscode").call("workbench.action.closeActiveEditor")<CR>',
		desc = "Close file",
	},
	{ "<leader>ee", ":edit<Space>", desc = "New buffer (input filename)" },
	{
		"[b",
		'<cmd>lua require("vscode").call("workbench.action.previousEditor")<CR>',
		desc = "Close file",
	},
	{
		"]b",
		'<cmd>lua require("vscode").call("workbench.action.nextEditor")<CR>',
		desc = "Close file",
	},
	{
		"H",
		'<cmd>lua require("vscode").call("workbench.action.previousEditor")<CR>',
		desc = "Close file",
	},
	{
		"L",
		'<cmd>lua require("vscode").call("workbench.action.nextEditor")<CR>',
		desc = "Close file",
	},
	{ "<leader>T", ":tabnew<Space>", desc = "New tab (input filename)" },
	{
		"<C-j>",
		'<cmd>lua require("vscode").call("editor.action.moveLinesDownAction")<CR>',
		desc = "Move line down",
	},
	{ "<C-k>", '<cmd>lua require("vscode").call("editor.action.moveLinesUpAction")<CR>', desc = "Move line up" },
	{ "<leader>V", ":split<Space>", desc = "Horizontal split (input filename)" },
	{ "<leader>v", ":vsplit<Space>", desc = "Vertical split (input filename)" },
	{
		"<leader>h",
		'<cmd>lua require("vscode").call("workbench.action.focusLeftGroup")<CR>',
		desc = "Focus left window",
	},
	{
		"<leader>j",
		'<cmd>lua require("vscode").call("workbench.action.focusBelowGroup")<CR>',
		desc = "Focus below window",
	},
	{
		"<leader>k",
		'<cmd>lua require("vscode").call("workbench.action.focusAboveGroup")<CR>',
		desc = "Focus above window",
	},
	{
		"<leader>l",
		'<cmd>lua require("vscode").call("workbench.action.focusRightGroup")<CR>',
		desc = "Focus right window",
	},
	{
		"<leader>-",
		'<cmd>lua require("vscode").call("workbench.action.splitEditorDown")<CR>',
	},
	{
		"<leader>|",
		'<cmd>lua require("vscode").call("workbench.action.splitEditorRight")<CR>',
	},
}
