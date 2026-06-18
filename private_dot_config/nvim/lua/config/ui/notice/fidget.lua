local ok, fidget = pcall(require, "fidget")
if not ok then
	return
end
fidget.setup({
	progress = {
		suppress_on_insert = true,
		display = {
			done_ttl = 1,
		},
		ignore_empty_message = true,
		ignore_done_already = true,
	},
})
