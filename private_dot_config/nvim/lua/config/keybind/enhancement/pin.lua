-- <leader>+number --
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

-- pin --
return {
	-- harpoon --
	{
		{
			"<leader>pp",
			'<cmd>lua require("harpoon"):list():add()<CR>',
			desc = "Pin file",
		},
		{
			"<leader>fp",
			"<cmd>Telescope harpoon marks<CR>",
			-- function()
			-- 	local harpoon = require("harpoon")
			-- 	harpoon.ui:toggle_quick_menu(harpoon:list())
			-- end,
			desc = "Pinned files",
		},
		harpoon_nbr_keys,
	},
}
