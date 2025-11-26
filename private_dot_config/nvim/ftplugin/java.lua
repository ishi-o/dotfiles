-- require("java").setup()

local conf = require("config.lsp.conf")

local mason_dir = vim.fn.stdpath("data") .. "/mason"
-- local pkg_dir = mason_dir .. "/packages"
local share_dir = mason_dir .. "/share"
local lombok_path = share_dir .. "/jdtls/lombok.jar"
-- local jdtls_jar = vim.fn.glob(share_dir .. "/plugins/org.eclipse.equinox.launcher_*.jar", 1)
local root_dir = vim.fs.root(0, { "gradlew", "mvnw", "pom.xml", ".git" })

local bundles = {
	vim.fn.glob(share_dir .. "/java-debug-adapter/com.microsoft.java.debug.plugin-*.jar", 1),
	lombok_path,
}
local jar_files = vim.split(vim.fn.glob(share_dir .. "/vscode-spring-boot-tools/jdtls/*.jar"), "\n")
for _, jar_file in ipairs(jar_files) do
	table.insert(bundles, jar_file)
end

vim.lsp.config("jdtls", {
	cmd = {
		"jdtls",
		string.format("--jvm-arg=-javaagent:%s", lombok_path),
		"-configuration",
		vim.fn.stdpath("cache") .. "/jdtls/" .. root_dir .. "/config",
		"-data",
		vim.fn.stdpath("cache") .. "/jdtls/" .. root_dir .. "/workspace",
	},
	root_dir = root_dir,
	init_options = {
		bundles = bundles,
	},
	on_attach = function(client, bufnr)
		conf.on_attach(client, bufnr)
		-- local jdtls_dap = require("jdtls.dap")
		-- jdtls_dap.setup_dap({ hotcodereplace = "auto" })
		-- jdtls_dap.setup_dap_main_class_configs()
		-- if client.supports_method("textDocument/semanticTokens") then
		-- 	client.server_capabilities.semanticTokensProvider = nil
		-- end
	end,
	capabilities = conf.capabilities,
	filetypes = { "java", "jproperties", "yaml" },
	settings = {
		java = {
			inlayHints = {
				enabled = true,
				parameterNames = {
					enabled = "all",
				},
			},
		},
	},
})

local dap = require("dap")

dap.configurations.java = {
	{
		type = "java",
		request = "launch",
		name = "Debug Java Application",
		mainClass = function()
			local main_classes = {}
			local java_files = vim.fn.globpath(vim.fn.getcwd(), "**/*.java", false, true)

			for _, file in ipairs(java_files) do
				local content = table.concat(vim.fn.readfile(file), "\n")
				local clean_content = content:gsub("/%*.-%*/", ""):gsub("//[^\n]*", "")

				if clean_content:match("public%s+static%s+void%s+main%s*%(%s*String%[%]%s+[%w_]+%s*%)") then
					local package = content:match("package%s+([%w._]+);")
					local class_name = file:match("([%w_]+)%.java$")
					local full_name = package and (package .. "." .. class_name) or class_name
					local file_name = file:match("([^/]+)$")

					table.insert(main_classes, {
						value = full_name,
						display = full_name .. "\t" .. file_name,
					})
				end
			end

			if #main_classes == 0 then
				return ""
			elseif #main_classes == 1 then
				return main_classes[1].value
			else
				local selected_class = ""
				local co = coroutine.running()

				vim.ui.select(main_classes, {
					prompt = "Select Main Class:",
					format_item = function(item)
						return item.display
					end,
				}, function(choice)
					if choice then
						selected_class = choice.value
					end
					if co then
						coroutine.resume(co)
					end
				end)

				if co then
					coroutine.yield()
				end

				return selected_class
			end
		end,
		projectName = vim.fn.getcwd():match("([^/]+)$"),
		classPaths = { vim.fn.getcwd() .. "/target/classes" },
		modulePaths = {},
	},
}

dap.adapters.java = function(callback, config)
	vim.lsp.get_clients({ name = "jdtls" })[1]:request("workspace/executeCommand", {
		command = "vscode.java.startDebugSession",
	}, function(_, port)
		callback({
			type = "server",
			host = "127.0.0.1",
			port = tonumber(port),
		})
	end)
end
