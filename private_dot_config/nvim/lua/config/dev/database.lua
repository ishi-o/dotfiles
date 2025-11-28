local map = vim.keymap.set

vim.g.db_ui_use_nerd_fonts = 1

map("n", "<leader>db", "<cmd>DBUIToggle<CR>", { desc = "Toggle Database UI" })
