local autocmd = vim.api.nvim_create_autocmd

autocmd({ "BufRead", "BufNewFile" }, {
	pattern = {
		"*.png",
		"*.jpg",
		"*.jpeg",
		"*.jfif",
		"*.pjpeg",
		"*.pjp",
		"*.gif",
		"*.bmp",
		"*.dib",
		"*.webp",
		"*.tiff",
		"*.tif",
		"*.ico",
		"*.svg",
		"*.svgz",
		"*.heic",
		"*.heif",
		"*.avif",
		"*.psd",
		"*.xpm",
		"*.xbm",
		"*.pcx",
		"*.tga",
		"*.hdr",
		"*.exr",
		"*.raw",
		"*.cr2",
		"*.nef",
	},
	callback = function()
		vim.bo.filetype = "image"
	end,
})

autocmd("FileType", {
	pattern = "http",
	callback = function()
		local map = vim.keymap.set
		map("n", "<leader>Rb", "<cmd>lua require('kulala').scratchpad()<CR>", { buffer = true })
		map("n", "<leader>Rc", "<cmd>lua require('kulala').copy()<CR>", { buffer = true })
		map("n", "<leader>RC", "<cmd>lua require('kulala').from_curl()<CR>", { buffer = true })
		map("n", "<leader>Re", "<cmd>lua require('kulala').set_selected_env()<CR>", { buffer = true })
		map("n", "<leader>Rg", "<cmd>lua require('kulala').download_graphql_schema()<CR>", { buffer = true })
		map("n", "<leader>Ri", "<cmd>lua require('kulala').inspect()<CR>", { buffer = true })
		map("n", "<leader>Rn", "<cmd>lua require('kulala').jump_next()<CR>", { buffer = true })
		map("n", "<leader>Rp", "<cmd>lua require('kulala').jump_prev()<CR>", { buffer = true })
		map("n", "<leader>Rq", "<cmd>lua require('kulala').close()<CR>", { buffer = true })
		map("n", "<leader>Rr", "<cmd>lua require('kulala').replay()<CR>", { buffer = true })
		map("n", "<leader>Rs", "<cmd>lua require('kulala').run()<CR>", { buffer = true })
		map("n", "<leader>RS", "<cmd>lua require('kulala').show_stats()<CR>", { buffer = true })
		map("n", "<leader>Rt", "<cmd>lua require('kulala').toggle_view()<CR>", { buffer = true })
	end,
})

autocmd("FileType", {
	pattern = "python",
	callback = function()
		local map = vim.keymap.set
		map("n", "<leader>cv", "<cmd>:VenvSelect<CR>", { buffer = true })
	end,
})

autocmd("FileType", {
	pattern = "markdown",
	callback = function()
		local map = vim.keymap.set
		map("i", "（", "（）<Esc>i", { buffer = true, silent = true, desc = "Insert pair （）" })
		map("i", "【", "【】<Esc>i", { buffer = true, silent = true, desc = "Insert pair 【】" })
		map("i", "《", "《》<Esc>i", { buffer = true, silent = true, desc = "Insert pair 《》" })
		map("n", "<leader>M", "<cmd>MarkdownPreview<CR>", { buffer = true })
	end,
})

autocmd("BufReadPost", {
	pattern = "*.csv",
	callback = function()
		vim.cmd("CsvViewEnable display_mode=border header_lnum=1")
	end,
	desc = "Preprocess Csv File",
})

autocmd("FileType", {
	pattern = "csv",
	callback = function()
		local map = vim.keymap.set
		map("n", "<leader>M", "<cmd>CsvViewToggle display_mode=border header_lnum=1<CR>", { buffer = true })
	end,
})

autocmd("FileType", {
	pattern = "typst",
	callback = function()
		local map = vim.keymap.set
		map("n", "<leader>M", "<cmd>TypstPreview<CR>", { buffer = true })
	end,
})

autocmd("LspProgress", {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		local name = client and client.name or "LSP"
		local value = ev.data.params and ev.data.params.value
		if not value then
			return
		end

		local parts = {}
		if value.kind == "end" then
			table.insert(parts, "Done")
		else
			if value.title and value.title ~= "" then
				table.insert(parts, value.title)
			end
			if value.message and value.message ~= "" then
				table.insert(parts, value.message)
			end
			if value.percentage then
				table.insert(parts, string.format("(%d%%%%)", value.percentage))
			end
		end

		if #parts == 0 then
			return
		end

		local msg = table.concat(parts, " ")
		vim.api.nvim_echo({ { ("[%s] %s"):format(name, msg) } }, false, {
			id = ("progress-lsp-%s-%s"):format(ev.data.client_id, value.title or value.kind or "progress"),
			kind = "progress",
			title = ("[%s] %s"):format(name, value.title or "Progress"),
			status = value.kind == "end" and "success" or "running",
			percent = value.percentage,
		})
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
