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
