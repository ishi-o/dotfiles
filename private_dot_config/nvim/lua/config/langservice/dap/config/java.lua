local dap = require("dap")

dap.configurations.java = {
	{
		type = "java",
		request = "launch",
		name = "Launch API CN",
		mainClass = "io.kingboat.superlight.SuperlightApplication",
		projectName = "superlight-api",
		vmArgs = "--add-opens=java.base/java.lang=ALL-UNNAMED",
		console = "externalTerminal",
		env = {
			SERVER_PORT = "8080",
			SPRING_PROFILES_ACTIVE = "local,love-matters-cn,enjoy-pay",
			SPRING_DATA_MONGODB_URI = "mongodb://love-matters:love-matters@localhost:27017/love-matters",
			APP_IP_LOCATION_SERVICE_URL = "http://localhost:3000",
			APP_FAKE_USER_INFO_SERVICE_URL = "http://localhost:3001",
			SPRING_DATA_REDIS_HOST = "localhost",
			SPRING_DATA_REDIS_DATABASE = "0",
			SPRING_CACHE_TYPE = "redis",
		},
	},
	{
		type = "java",
		request = "launch",
		name = "Launch API screw",
		mainClass = "io.kingboat.superlight.SuperlightApplication",
		projectName = "superlight-api",
		vmArgs = "--add-opens=java.base/java.lang=ALL-UNNAMED",
		console = "externalTerminal",
		env = {
			SERVER_PORT = "8080",
			SPRING_PROFILES_ACTIVE = "local,love-fashion",
			SPRING_DATA_MONGODB_URI = "mongodb://nsplay-fun:nsplay-fun@localhost:27017/nsplay-fun",
		},
	},
	{
		type = "java",
		request = "launch",
		name = "Launch Bot AI",
		mainClass = "io.kingboat.superlight.BotApplication",
		projectName = "superlight-bot",
		vmArgs = "--add-opens=java.base/java.lang=ALL-UNNAMED",
		console = "externalTerminal",
		env = {
			SERVER_PORT = "8080",
			SPRING_PROFILES_ACTIVE = "local,local-ai,bot,gitlab",
			SPRING_DATA_MONGODB_URI = "mongodb://love-matters:love-matters@localhost:27017/love-matters",
			LOGGING_LEVEL_IO_KINGBOAT = "DEBUG",
		},
	},
	{
		type = "java",
		request = "launch",
		name = "Launch Redirect",
		mainClass = "io.kingboat.redirect.RedirectApplication",
		projectName = "superlight-redirect",
		vmArgs = "--add-opens=java.base/java.lang=ALL-UNNAMED",
		console = "externalTerminal",
		env = {
			SERVER_PORT = "8080",
			SPRING_PROFILES_ACTIVE = "local,redirect",
			SPRING_DATA_MONGODB_URI = "mongodb://love-matters:love-matters@localhost:27017/love-matters",
			LOGGING_LEVEL_IO_KINGBOAT = "DEBUG",
		},
	},
	{
		type = "java",
		request = "launch",
		name = "Launch Tester",
		mainClass = "io.kingboat.superlight.SuperlightApplication",
		projectName = "superlight-api",
		vmArgs = "--add-opens=java.base/java.lang=ALL-UNNAMED",
		console = "externalTerminal",
		env = {
			SERVER_PORT = "8080",
			SPRING_PROFILES_ACTIVE = "test-lewan-add-home,nvwuzhiren-zfb",
			SPRING_DATA_MONGODB_URI = "mongodb://love-matters:love-matters@localhost:27017/love-matters",
		},
	},
	{
		type = "java",
		request = "launch",
		name = "Launch API watermelon",
		mainClass = "io.kingboat.superlight.SuperlightApplication",
		projectName = "superlight-api",
		vmArgs = "--add-opens=java.base/java.lang=ALL-UNNAMED",
		console = "externalTerminal",
		env = {
			SERVER_PORT = "8080",
			SPRING_PROFILES_ACTIVE = "local,watermelon",
			SPRING_DATA_MONGODB_URI = "mongodb://watermelon:watermelon@localhost:27017/watermelon",
		},
	},
	{
		type = "java",
		request = "launch",
		name = "Launch ToolsApplication",
		mainClass = "io.kingboat.superlight.ToolsApplication",
		projectName = "superlight-tools",
	},
	{
		type = "java",
		request = "launch",
		name = "Launch Jobs User Level Update",
		mainClass = "io.kingboat.superlight.JobsApplication",
		projectName = "superlight-jobs",
		console = "externalTerminal",
		env = {
			SPRING_DATA_MONGODB_URI = "mongodb://word-master:word-master@localhost:27017/word-master",
			SPRING_PROFILES_ACTIVE = "user-level-bot-updating-overall-rolling-job,jobs",
			STORAGE_LOCATION = "/tmp/love-matters-cn",
		},
	},
	{
		type = "java",
		request = "launch",
		name = "Launch Jobs User Level Rolling Update",
		mainClass = "io.kingboat.superlight.JobsApplication",
		projectName = "superlight-jobs",
		console = "externalTerminal",
		env = {
			SPRING_DATA_MONGODB_URI = "mongodb://screw-fantasy:screw-fantasy@localhost:27017/screw-fantasy",
			SPRING_PROFILES_ACTIVE = "user-level-bot-updating-overall-rolling-job,jobs",
			STORAGE_LOCATION = "/tmp/love-matters-cn",
		},
	},
	{
		type = "java",
		request = "launch",
		name = "Launch OPS Server",
		mainClass = "io.kingboat.superlight.OpsApplication",
		projectName = "superlight-ops",
		console = "externalTerminal",
		env = {
			SPRING_PROFILES_ACTIVE = "love-matters-cn,local,local-proxy",
			SERVER_PORT = "8081",
			SPRING_DATA_MONGODB_URI = "mongodb://love-matters:love-matters@localhost:27017/love-matters",
			SPRING_SESSION_STORE_TYPE = "none",
			LOGGING_LEVEL_ROOT = "INFO",
		},
	},
	{
		type = "java",
		request = "launch",
		name = "Launch Content Modules Job",
		mainClass = "io.kingboat.superlight.JobsApplication",
		projectName = "superlight-jobs",
		console = "externalTerminal",
		env = {
			SPRING_PROFILES_ACTIVE = "love-matters-cn,local,local-proxy,ai-content-module-updater,jobs",
			LOGGING_LEVEL_ROOT = "INFO",
			SPRING_DATA_MONGODB_URI = "mongodb://love-matters:love-matters@localhost:27017/love-matters",
			SPRING_SESSION_STORE_TYPE = "none",
			STORAGE_LOCATION = "/tmp/love-matters-cn",
			STORAGE_BASE_URL = "http://localhost:8080/love-matters-cn/%s",
			STORAGE_CDN_URL = "http://localhost:8080/love-matters-cn/%s",
		},
	},
	{
		type = "java",
		request = "launch",
		name = "Launch wechat notification pusher life reset",
		mainClass = "io.kingboat.superlight.JobsApplication",
		projectName = "superlight-jobs",
		console = "externalTerminal",
		env = {
			SPRING_DATA_MONGODB_URI = "mongodb://love-matters:love-matters@localhost:27017/love-matters",
			SPRING_PROFILES_ACTIVE = "local,wechat-notification-pusher-life-reset",
		},
	},
	{
		type = "java",
		request = "launch",
		name = "App Info Updater LF",
		mainClass = "io.kingboat.superlight.JobsApplication",
		projectName = "superlight-jobs",
		console = "externalTerminal",
		env = {
			SPRING_DATA_MONGODB_URI = "mongodb://love-fashion:love-fashion@localhost:27017/love-fashion",
			SPRING_PROFILES_ACTIVE = "app-information-updater,staging,love-fashion",
		},
	},
	{
		type = "java",
		request = "launch",
		name = "Feishu Bot",
		mainClass = "io.kingboat.superlight.BotApplication",
		projectName = "superlight-bot",
		console = "externalTerminal",
		env = {
			SPRING_DATA_MONGODB_URI = "mongodb://love-matters:love-matters@localhost:27017/love-matters",
		},
	},
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
