return {
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
