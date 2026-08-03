return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		version = false,
		build = ":TSUpdate",
		config = function()
			require("config.langs.treesitter")
		end,
	},
	{
		"alker0/chezmoi.vim",
		init = function()
			vim.g["chezmoi#use_tmp_buffer"] = 1
			vim.g["chezmoi#source_dir_path"] = vim.env.HOME .. "/.local/share/chezmoi"
		end,
	},
}
