local M = {}

function M.setup()
	vim.g.loaded_matchparen = 1
end

function M.load_sentiment()
	require("sentiment").setup({})
end

return M
