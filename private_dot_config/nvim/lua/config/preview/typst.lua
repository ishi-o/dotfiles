local ok, typst_preview = pcall(require, "typst-preview")
if ok then
	typst_preview.setup({})
end
