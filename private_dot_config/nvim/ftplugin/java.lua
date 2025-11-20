vim.keymap.set("n", "<F5>", function()
	local function find_project_root()
		-- 获取当前文件所在目录
		local current_dir = vim.fn.expand("%:p:h")

		-- 向上查找项目根目录标记文件
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

		-- 如果没找到，使用当前文件所在目录
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

		-- 提取包名
		local package_name = ""
		for line in content:gmatch("[^\r\n]+") do
			local package_match = line:match("^%s*package%s+([%w_.]+);")
			if package_match then
				package_name = package_match
				break
			end
		end

		-- 简化的主类检测：查找包含main方法的类
		local main_method_pattern = "public%s+static%s+void%s+main%s*%(%s*String%[%]%s+[%w_]*%s*%)"

		if content:find(main_method_pattern) then
			-- 查找类名
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

		-- 检查项目根目录是否有pom.xml
		local pom_exists = vim.fn.filereadable(project_root .. "/pom.xml") == 1

		if not pom_exists then
			vim.notify("No pom.xml found in project root: " .. project_root, vim.log.levels.ERROR)
			return
		end

		-- 检测是否为Spring Boot项目
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

		-- 安全地使用toggleterm
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

	-- 检查文件类型
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
