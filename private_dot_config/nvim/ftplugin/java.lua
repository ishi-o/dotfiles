local conf = require("config.lsp.conf")

local config = {
	name = "jdtls",
	cmd = { "jdtls" },
	root_dir = vim.fs.root(0, { "gradlew", ".git", "mvnw", "pom.xml" }),
	init_options = {
		bundles = {
			vim.fn.glob(
				vim.fn.stdpath("data")
					.. "/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar",
				1
			),
		},
	},
	on_attach = function(client, bufnr)
		conf.on_attach(client, bufnr)
		local jdtls_dap = require("jdtls.dap")
		jdtls_dap.setup_dap({ hotcodereplace = "auto" })
		jdtls_dap.setup_dap_main_class_configs()
	end,
	-- capabilities = conf.capabilities,
}
require("jdtls").start_or_attach(config)
