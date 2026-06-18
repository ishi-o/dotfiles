local ok, codewindow = pcall(require, "codewindow")
if not ok then
	return
end
codewindow.setup()
-- codewindow.apply_default_keybinds()
