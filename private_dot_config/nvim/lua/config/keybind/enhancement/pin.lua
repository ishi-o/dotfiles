local harpoon_nbr_keys = {}
for i = 1, 5 do
	table.insert(harpoon_nbr_keys, {
		"<leader>p" .. i,
		function()
			require("harpoon"):list():select(i)
		end,
		desc = "Harpoon to File " .. i,
	})
end

return {
	{
		cond = function()
			return _G.plugin_installed("harpoon")
		end,
		{
			"<leader>pp",
			'<cmd>lua require("harpoon"):list():add()<CR>',
			desc = "Pin file",
		},
		{
			"<leader>fp",
			"<cmd>lua Snacks.picker('harpoon')<CR>",
			desc = "Pinned files",
		},
		harpoon_nbr_keys,
	},
}
