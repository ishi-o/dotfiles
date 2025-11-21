local dap = require("dap")

vim.keymap.set("n", "<F5>", require("dap").continue, { desc = "Debug: Continue" })
vim.keymap.set("n", "<F10>", require("dap").step_over, { desc = "Debug: Step Over" })
vim.keymap.set("n", "<F11>", require("dap").step_into, { desc = "Debug: Step Into" })
vim.keymap.set("n", "<F9>", require("dap").toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
