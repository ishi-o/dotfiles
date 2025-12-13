return {
	-- csvview.nvim --
	-- csv preview
	-- csv 文件预览 ui 优化
	{
		"hat0uma/csvview.nvim",
		lazy = true,
		cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
		ft = { "csv" },
		config = function()
			require("config.preview.csv")
		end,
	},
}
