return {
	{
		"linux-cultist/venv-selector.nvim",
		cmd = "VenvSelect",
		ft = "python",
		config = function()
			require("config.extra.pyenv")
		end,
	},
}
