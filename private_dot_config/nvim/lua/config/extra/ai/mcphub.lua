local ok, mcphub = pcall(require, "mcphub")
if ok then
	mcphub.setup({
		extensions = {
			avante = {
				make_slash_commands = true,
			},
		},
	})
end
