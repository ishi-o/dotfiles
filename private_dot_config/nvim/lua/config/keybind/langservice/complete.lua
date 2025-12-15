-- complete --
return {
	-- insert mode --
	{
		mode = "i",

		{ "<Tab>", desc = "Confirm complete" },
		{ "<A-k>", desc = "Prev complete item" },
		{ "<A-j>", desc = "Next complete item" },
	},
	-- command mode --
	{
		mode = "c",

		{ "<Tab>", desc = "Prev complete item" },
		{ "<S-Tab>", desc = "Next complete item" },
	},

	{ "<C-Space>", desc = "Toggle: complete panel", mode = { "i", "c" } },
}
