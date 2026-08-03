function _G.plugin_installed(name)
	local data_path = vim.fn.stdpath("data")
	local plugin_path = data_path .. "/lazy/" .. name
	return vim.fn.isdirectory(plugin_path) == 1
end
