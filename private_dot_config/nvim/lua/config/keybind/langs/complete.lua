return {
	{
		mode = "i",
		{ "<Tab>", desc = "Confirm complete" },
		{ "<A-k>", desc = "Prev complete item" },
		{ "<A-j>", desc = "Next complete item" },
	},
	{
		mode = "c",
		{ "<Tab>", desc = "Prev complete item" },
		{ "<S-Tab>", desc = "Next complete item" },
	},
	{ "<C-y>", desc = "Toggle: complete panel", mode = { "i", "c" } },
}
