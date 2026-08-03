local conf = require("config.langs.lsp.conf")

local function resolve_java_home()
	if vim.env.JAVA_HOME and vim.env.JAVA_HOME ~= "" then
		return vim.env.JAVA_HOME, nil
	end

	if vim.fn.executable("/usr/libexec/java_home") == 1 then
		local home = vim.trim(vim.fn.system({ "/usr/libexec/java_home" }))
		if vim.v.shell_error == 0 and home ~= "" then
			return home, nil
		end
	end

	return nil, nil
end

local function resolve_java_runtimes()
	local java_home, version = resolve_java_home()
	if not java_home then
		return {}
	end
	return {
		{
			name = "JavaSE-" .. (version or "21"),
			path = java_home,
		},
	}
end

local function glob_jars(pattern)
	return vim.split(vim.fn.glob(pattern), "\n", { trimempty = true })
end

local mason_share = vim.fn.stdpath("data") .. "/mason/share"
local bundles = {}
vim.list_extend(bundles, glob_jars(mason_share .. "/java-debug-adapter/*.jar"))
vim.list_extend(bundles, glob_jars(mason_share .. "/java-test/*.jar"))

vim.lsp.config("jdtls", {
	on_attach = function(client, bufnr)
		conf.on_attach(client, bufnr)

		local jdtls = require("jdtls")
		vim.keymap.set("n", "<leader>co", function()
			jdtls.organize_imports()
		end, {
			buffer = bufnr,
			desc = "Organize Imports",
		})
	end,
	capabilities = conf.capabilities,
	settings = {
		java = {
			configuration = {
				runtimes = resolve_java_runtimes(),
			},
			signatureHelp = {
				enabled = true,
			},
			inlayHint = {
				enabled = true,
			},
		},
	},
	init_options = {
		bundles = bundles,
		workspace = {
			didChangeWatchedFiles = {
				dynamicRegistration = true,
			},
			refresh = {
				enabled = true,
			},
		},
		extendedClientCapabilities = require("jdtls").extendedClientCapabilities,
	},
})
