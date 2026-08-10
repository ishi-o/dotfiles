local autocmd = _G.UserUtils.autocmd
local pending_tab_buffers = {}

autocmd({ "BufEnter", "BufWinEnter" }, {
	callback = _G.UserUtils.track_tab_buffers,
})

autocmd("TabClosedPre", {
	callback = function()
		pending_tab_buffers[#pending_tab_buffers + 1] = _G.UserUtils.get_tab_buffers()
	end,
})

autocmd("TabClosed", {
	callback = function()
		local buffers = table.remove(pending_tab_buffers, 1)
		if not buffers then
			return
		end

		local buffers_in_other_tabs = {}
		for _, tab in ipairs(vim.api.nvim_list_tabpages()) do
			for buf in pairs(_G.UserUtils.get_tab_buffers(tab)) do
				buffers_in_other_tabs[buf] = true
			end
		end

		local skipped_buffers = {}
		for buf in pairs(buffers) do
			if not buffers_in_other_tabs[buf] and vim.api.nvim_buf_is_valid(buf) then
				local is_terminal = vim.bo[buf].buftype == "terminal"
				local ok = is_terminal or not vim.bo[buf].modified

				if ok then
					ok = pcall(vim.api.nvim_buf_delete, buf, { force = is_terminal })
				end

				if not ok then
					local name = vim.api.nvim_buf_get_name(buf)
					skipped_buffers[#skipped_buffers + 1] = name ~= "" and name or "[No Name]"
				end
			end
		end

		if #skipped_buffers > 0 then
			vim.notify(
				"Buffers kept after closing tab: " .. table.concat(skipped_buffers, ", "),
				vim.log.levels.WARN
			)
		end
	end,
})

autocmd("FileType", {
	pattern = "markdown",
	callback = function()
		local map = vim.keymap.set
		map("i", "（", "（）<Esc>i", { buffer = true, silent = true, desc = "Insert pair （）" })
		map("i", "【", "【】<Esc>i", { buffer = true, silent = true, desc = "Insert pair 【】" })
		map("i", "《", "《》<Esc>i", { buffer = true, silent = true, desc = "Insert pair 《》" })
	end,
})

autocmd("FileType", {
	pattern = "go",
	callback = function()
		local map = vim.keymap.set
		map("n", "<leader>ci", function()
			local inputs = {}
			local function ask(prompt, default, callback)
				vim.ui.input({ prompt = prompt, default = default }, function(value)
					if value and value ~= "" then
						table.insert(inputs, value)
						if callback then
							callback()
						end
					end
				end)
			end
			ask("Receiver type (e.g., *MyStruct): ", "*", function()
				ask("Parameter name: ", "", function()
					ask("Interface name (e.g., io.Reader): ", "", function()
						local cmd = string.format("impl '%s %s' %s", inputs[2], inputs[1], inputs[3])
						local handle = io.popen(cmd)
						if handle then
							local result = handle:read("*a")
							handle:close()
							if result and result ~= "" then
								vim.api.nvim_put(vim.split(result, "\n"), "l", false, true)
							end
						end
					end)
				end)
			end)
		end, { desc = "Generate go implementation" })
	end,
})

do
	local ns = vim.api.nvim_create_namespace("bracket_hl")

	autocmd("CursorHold", {
		callback = function()
			local buf = vim.api.nvim_get_current_buf()
			if vim.bo[buf].filetype == "bigfile" then
				return
			end
			vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)

			local open = vim.fn.searchpairpos("[[({]", "", "[])}]", "nbW")
			local close = vim.fn.searchpairpos("[[({]", "", "[])}]", "nW")

			if open[1] ~= 0 and close[1] ~= 0 then
				vim.api.nvim_buf_set_extmark(buf, ns, open[1] - 1, open[2] - 1, {
					end_col = open[2],
					hl_group = "MatchParen",
				})
				vim.api.nvim_buf_set_extmark(buf, ns, close[1] - 1, close[2] - 1, {
					end_col = close[2],
					hl_group = "MatchParen",
				})
			end
		end,
	})
end
