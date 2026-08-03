local ok, mcphub = pcall(require, "mcphub")
if ok then
	vim.env.ALLOWED_DIRECTORY = vim.fn.getcwd()
	vim.env.REPOSITORY_PATH = vim.fn.getcwd()

	mcphub.setup({
		extensions = {
			avante = {
				make_slash_commands = true,
			},
		},
	})
end
