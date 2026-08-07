return {
	{
		cond = function()
			return _G.UserUtils.plugin_installed("mini.surround")
		end,
		{ "gsa", desc = "Add Surrounding", mode = { "n", "x" } },
		{ "gsd", desc = "Delete Surrounding" },
		{ "gsf", desc = "Find Right Surrounding" },
		{ "gsF", desc = "Find Left Surrounding" },
		{ "gsh", desc = "Highlight Surrounding" },
		{ "gsr", desc = "Replace Surrounding" },
		{ "gsn", desc = "Update `MiniSurround.config.n_lines`" },
	},
}
