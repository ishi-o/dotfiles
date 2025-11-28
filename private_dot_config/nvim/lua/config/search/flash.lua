require("flash")

local map = vim.keymap.set

map({ "n", "x", "o" }, "s", function()
	require("flash").jump()
end)

map({ "n", "x", "o" }, "S", function()
	require("flash").treesitter()
end)

map("o", "r", function()
	require("flash").remote()
end)

map({ "o", "x" }, "R", function()
	require("flash").treesitter_search()
end)

map("c", "<c-s>", function()
	require("flash").toggle()
end)
