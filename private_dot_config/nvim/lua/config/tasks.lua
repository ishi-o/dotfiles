require("overseer").setup({
	templates = {
		"builtin",
		"user.cpp_build",
		"user.cpp_run",
		"user.cpp_build-run",
		"user.java",
		"user.go",
	},
})

vim.keymap.set("n", "<F5>", "<cmd>OverseerRun<CR>", { desc = "Build & Run" })
