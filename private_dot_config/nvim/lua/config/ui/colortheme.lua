local hlset = vim.api.nvim_set_hl
vim.g.everforest_background = "soft"

vim.cmd("colorscheme everforest")
hlset(0, "NormalFloat", { bg = "#E8DFC8", fg = "#5C6A72" })
hlset(0, "FloatBorder", { link = "Normal" })

hlset(0, "DiffText", { bg = "#A8D5B1", fg = "#24292F" })
-- hlset(0, "DiffText", { bg = "#9ED9A8", fg = "#24292F" })
hlset(0, "VirtualTextOk", { link = "DiagnosticOk" })
hlset(0, "VirtualTextHint", { link = "DiagnosticHint" })
hlset(0, "VirtualTextInfo", { link = "DiagnosticInfo" })
hlset(0, "VirtualTextWarning", { link = "DiagnosticWarning" })
hlset(0, "VirtualTextError", { link = "DiagnosticError" })
vim.api.nvim_create_autocmd("OptionSet", {
	pattern = "background",
	callback = function()
		hlset(0, "DiffText", { bg = "#A8D5B1", fg = "#24292F" })
		hlset(0, "VirtualTextOk", { link = "DiagnosticOk" })
		hlset(0, "VirtualTextHint", { link = "DiagnosticHint" })
		hlset(0, "VirtualTextInfo", { link = "DiagnosticInfo" })
		hlset(0, "VirtualTextWarning", { link = "DiagnosticWarning" })
		hlset(0, "VirtualTextError", { link = "DiagnosticError" })
	end,
})

-- vim.cmd("colorscheme tokyonight")
