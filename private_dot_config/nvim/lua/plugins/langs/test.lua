return {
	{
		"nvim-neotest/neotest",
		cmd = { "Neotest" },
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			{
				"fredrikaverpil/neotest-golang",
				version = "*",
			},
			"rcasia/neotest-java",
		},
		config = function()
			require("neotest").setup({
				adapters = {
					require("neotest-golang")({}),
					require("neotest-java")({}),
				},
			})
		end,
	},
}
