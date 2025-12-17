vim.g.everforest_background = "soft"

vim.cmd("colorscheme everforest")
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#E8DFC8", fg = "#5C6A72" })
vim.api.nvim_set_hl(0, "FloatBorder", { link = "Normal" })

-- vim.cmd("colorscheme tokyonight")
