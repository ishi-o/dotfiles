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

-- autocmd("BufWrite", {
-- 	pattern = "*.java",
-- 	callback = function()
-- 		vim.lsp.buf.code_action({
-- 			context = { only = { "source.organizeImports" } },
-- 			apply = true,
-- 		})
-- 	end,
-- })

autocmd("FileType", {
	pattern = "java",
	callback = function()
		local map = vim.keymap.set
		map("n", "<leader>yr", "<cmd>JavaRunnerRunMain<CR>", { buffer = true })
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

vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
	pattern = "*",
	callback = function()
		vim.defer_fn(function()
			if vim.bo.buftype == "" then
				vim.schedule(function()
					local mode = vim.api.nvim_get_mode().mode
					if mode == "n" then
						vim.api.nvim_win_call(0, function()
							vim.cmd("normal! zz")
						end)
					end
				end)
			end
		end, 200)
	end,
})

-- vim.api.nvim_create_autocmd("BufWritePost", {
-- 	pattern = "*.java",
-- 	callback = function()
-- 		vim.fn.jobstart("mvn compile", {
-- 			stdout_buffered = true,
-- 			stderr_buffered = true,
-- 		})
-- 	end,
-- 	desc = "Auto compile all Java files on save",
-- })
