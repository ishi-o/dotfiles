local ok, dap_virtual_text = pcall(require, "nvim-dap-virtual-text")
if ok then
	dap_virtual_text.setup({
		enabled = true,
		show_stop_reason = true,
		commented = false,
	})
end
