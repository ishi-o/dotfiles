return {
	-- kulala.nvim --
	-- http client support
	-- api 测试客户端支持
	{
		"mistweaverco/kulala.nvim",
		ft = { "http", "rest" },
		opts = {
			global_keymaps = false,
			global_keymaps_prefix = "<leader>R",
			kulala_keymaps_prefix = "",
		},
		config = function()
			require("config.extra.httpclient")
		end,
	},
}
