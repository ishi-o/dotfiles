local cmd = { vim.fn.exepath("jdtls") }

local lombok_jar = vim.fn.expand("$MASON/share/jdtls/lombok.jar")
if vim.fn.filereadable(lombok_jar) == 1 then
	table.insert(cmd, string.format("--jvm-arg=-javaagent:%s", lombok_jar))
end

local bundles = {}
local mason = vim.fn.expand("$MASON")
local paths = {
	mason .. "/share/java-debug-adapter/com.microsoft.java.debug.plugin-*.jar",
	mason .. "/share/java-test/*.jar",
	mason .. "/packages/vscode-spring-boot-tools/extension/jars/*.jar",
	mason .. "/packages/vscode-spring-boot-tools/extension/language-server/lib/*.jar",
	mason .. "/packages/vscode-spring-boot-tools/extension/language-server/spring-boot-language-server-*.jar",
}
for _, p in ipairs(paths) do
	vim.list_extend(bundles, vim.fn.glob(p, 1, 1))
end

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client and client.name == "jdtls" then
			require("jdtls").setup_dap({ hotcodereplace = "auto", config_overrides = {} })
			require("jdtls.dap").setup_dap_main_class_configs({})
		end
	end,
})

local conf = require("config.langservice.lsp.conf")

local function attach_jdtls()
	local fname = vim.api.nvim_buf_get_name(0)

	local root_dir = vim.fs.root(fname, vim.lsp.config.jdtls.root_markers)
	local project_name = root_dir and vim.fs.basename(root_dir)

	local full_cmd = vim.deepcopy(cmd)
	if project_name then
		local config_dir = vim.fn.stdpath("cache") .. "/jdtls/" .. project_name .. "/config"
		local workspace_dir = vim.fn.stdpath("cache") .. "/jdtls/" .. project_name .. "/workspace"
		vim.list_extend(full_cmd, {
			"-configuration",
			config_dir,
			"-data",
			workspace_dir,
		})
	end

	require("jdtls").start_or_attach({
		cmd = full_cmd,
		root_dir = root_dir,
		filetypes = { "java", "jproperties", "yaml", "yml" },
		on_attach = conf.on_attach,
		capabilities = conf.capabilities,
		init_options = {
			bundles = bundles,
		},
		settings = {
			java = {
				inlayHints = {
					parameterNames = {
						enabled = "all",
					},
				},
				signatureHelp = { enabled = true },
			},
		},
	})
end

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "java", "jproperties", "yaml", "yml" },
	callback = attach_jdtls,
})

-- for the first file
attach_jdtls()
