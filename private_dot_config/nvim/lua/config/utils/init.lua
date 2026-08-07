_G.UserUtils = _G.UserUtils or {}

function _G.UserUtils.plugin_installed(name)
	local data_path = vim.fn.stdpath("data")
	local plugin_path = data_path .. "/lazy/" .. name
	return vim.fn.isdirectory(plugin_path) == 1
end

_G.UserUtils.autocmd_group = _G.UserUtils.autocmd_group
	or vim.api.nvim_create_augroup("UserAutocmds", { clear = true })

function _G.UserUtils.autocmd(event, opts)
	opts.group = _G.UserUtils.autocmd_group
	return vim.api.nvim_create_autocmd(event, opts)
end

function _G.UserUtils.track_tab_buffers()
	local buffers = vim.t.bufferline_buffers or {}

	for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
		buffers[tostring(vim.api.nvim_win_get_buf(win))] = true
	end

	vim.t.bufferline_buffers = buffers
end

function _G.UserUtils.get_tab_buffers(tab)
	tab = tab or vim.api.nvim_get_current_tabpage()
	local buffers = {}
	local ok, cached = pcall(vim.api.nvim_tabpage_get_var, tab, "bufferline_buffers")

	if ok then
		for buf, included in pairs(cached) do
			local id = tonumber(buf)
			if included and id then
				buffers[id] = true
			end
		end
	end

	for _, win in ipairs(vim.api.nvim_tabpage_list_wins(tab)) do
		buffers[vim.api.nvim_win_get_buf(win)] = true
	end

	return buffers
end
