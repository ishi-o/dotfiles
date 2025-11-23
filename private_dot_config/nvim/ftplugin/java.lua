vim.keymap.set("n", "<C-F5>", function()
	local function find_project_root()
		local current_dir = vim.fn.expand("%:p:h")
		local root_markers = { "pom.xml", ".git", "mvnw", "gradlew", "build.gradle" }
		for _, marker in ipairs(root_markers) do
			local found = vim.fs.find(marker, {
				path = current_dir,
				upward = true,
			})
			if #found > 0 then
				return vim.fn.fnamemodify(found[1], ":h")
			end
		end
		return current_dir
	end

	local function find_main_classes(file_path)
		local main_classes = {}
		local file = io.open(file_path, "r")
		if not file then
			return main_classes
		end

		local content = file:read("*a")
		file:close()
		local package_name = ""
		for line in content:gmatch("[^\r\n]+") do
			local package_match = line:match("^%s*package%s+([%w_.]+);")
			if package_match then
				package_name = package_match
				break
			end
		end
		local main_method_pattern = "public%s+static%s+void%s+main%s*%(%s*String%[%]%s+[%w_]*%s*%)"
		if content:find(main_method_pattern) then
			local class_name = vim.fn.expand("%:t:r")
			local full_class_name = class_name
			if package_name ~= "" then
				full_class_name = package_name .. "." .. class_name
			end
			table.insert(main_classes, full_class_name)
		end

		return main_classes
	end

	local function run_java_class(main_class)
		local project_root = find_project_root()
		local pom_exists = vim.fn.filereadable(project_root .. "/pom.xml") == 1
		if not pom_exists then
			vim.notify("No pom.xml found in project root: " .. project_root, vim.log.levels.ERROR)
			return
		end
		local is_spring_boot = false
		local pom_file = io.open(project_root .. "/pom.xml", "r")
		if pom_file then
			local content = pom_file:read("*a")
			pom_file:close()
			is_spring_boot = content:find("spring%-boot") ~= nil
		end
		local command
		if is_spring_boot then
			command = string.format(
				"cd '%s' && mvn spring-boot:run -Dspring-boot.run.main-class='%s'",
				project_root,
				main_class
			)
		else
			command =
				string.format("cd '%s' && mvn compile exec:java -Dexec.mainClass='%s' -q", project_root, main_class)
		end

		vim.notify("Running: " .. main_class .. " in " .. project_root)
		local ok, toggleterm = pcall(require, "toggleterm.terminal")
		if ok then
			local Terminal = toggleterm.Terminal
			local term = Terminal:new({
				cmd = command,
				close_on_exit = false,
				direction = "horizontal",
			})
			term:toggle()
		else
			vim.notify("ToggleTerm not available, using built-in terminal")
			vim.cmd("terminal " .. command)
		end
	end
	local file_path = vim.fn.expand("%:p")
	if file_path == "" then
		vim.notify("No file found")
		return
	end
	if vim.bo.filetype ~= "java" then
		vim.notify("Not a Java file")
		return
	end
	local main_classes = find_main_classes(file_path)
	if not main_classes or #main_classes == 0 then
		vim.notify("No main class found in current file!")
		return
	end
	if #main_classes == 1 then
		run_java_class(main_classes[1])
		return
	end
	vim.ui.select(main_classes, {
		prompt = "Select Main Class to Run:",
		format_item = function(item)
			return item
		end,
	}, function(choice)
		if choice then
			run_java_class(choice)
		end
	end)
end, { buffer = true, desc = "Run Java File" })

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
		local jdtls_dap = require("jdtls.dap")
		jdtls_dap.setup_dap({ hotcodereplace = "auto" })
		jdtls_dap.setup_dap_main_class_configs()
		if client.server_capabilities.documentSymbolProvider then
			require("nvim-navic").attach(client, bufnr)
		end
	end,
}
require("jdtls").start_or_attach(config)
