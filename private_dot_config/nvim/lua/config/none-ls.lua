local null_ls = require("null-ls")

null_ls.setup({
    sources = {
--        null_ls.builtins.formatting.google_java_format,
        null_ls.builtins.diagnostics.checkstyle.with({
			extra_args = { "-c", os.getenv("HOME") .. "/.config/checkstyle/checkstyle.xml" },
		}),
    },
})
