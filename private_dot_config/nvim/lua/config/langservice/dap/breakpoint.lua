local ok, persistent_breakpoints = pcall(require, "persistent-breakpoints")
if ok then
	persistent_breakpoints.setup({
		load_breakpoints_event = { "BufReadPost" },
	})
end
