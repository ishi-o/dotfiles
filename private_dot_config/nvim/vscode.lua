require("config.lazy").setup()
require("config.settings")
require("lazy").setup({
	spec = {
		{ import = "plugins/keybind" },
	},
})
