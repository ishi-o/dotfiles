return {
	name = "Compile & Run Java with Maven",
	builder = function()
		local file = vim.fn.expand("%:p")
		local dir = vim.fn.expand("%:p:h")

		local is_spring_project = false
		local pom_file = dir .. "/pom.xml"

		if vim.fn.filereadable(pom_file) == 1 then
			local pom_content = vim.fn.readfile(pom_file)
			for _, line in ipairs(pom_content) do
				if
					string.find(line, "spring%-boot%-starter")
					or string.find(line, "springframework")
					or string.find(line, "spring%-boot%-parent")
				then
					is_spring_project = true
					break
				end
			end
		end

		local cmd = "mvn"
		local args = { "compile" }

		if is_spring_project then
			return {
				cmd = cmd,
				args = args,
				components = {
					{
						"on_output_parse",
						parser = {
							"on_output_parse",
							diagnostics_pattern = {
								{
									"%[ERROR%]%s+(.-):%[(%d+),(%d+)%]%s+(.*)",
									{ "file", "lnum", "col", "message" },
								},
								{
									"%[ERROR%]%s+(.-):(%d+)%s+%-%s+(.*)",
									{ "file", "lnum", "message" },
								},
							},
						},
						then_run = {
							{
								"run",
								cmd = { "mvn", "spring-boot:run" },
								components = {
									{ "on_output_quickfix", open = true },
									"default",
								},
							},
						},
					},
					"default",
				},
			}
		else
			local main_class = nil

			if vim.fn.filereadable(file) == 1 then
				local content = vim.fn.readfile(file)
				for _, line in ipairs(content) do
					if string.find(line, "public%s+static%s+void%s+main%s*%(%s*String") then
						local package_name = nil
						local class_name = vim.fn.expand("%:t:r")

						for _, package_line in ipairs(content) do
							local pkg_match = string.match(package_line, "^package%s+([%a][%w.]*);")
							if pkg_match then
								package_name = pkg_match
								break
							end
						end

						if package_name then
							main_class = package_name .. "." .. class_name
						else
							main_class = class_name
						end
						break
					end
				end
			end

			return {
				cmd = cmd,
				args = args,
				components = {
					{
						"on_output_parse",
						parser = {
							"on_output_parse",
							diagnostics_pattern = {
								{
									"%[ERROR%]%s+(.-):%[(%d+),(%d+)%]%s+(.*)",
									{ "file", "lnum", "col", "message" },
								},
								{
									"%[ERROR%]%s+(.-):(%d+)%s+%-%s+(.*)",
									{ "file", "lnum", "message" },
								},
							},
						},
						then_run = main_class and {
							{
								"run",
								cmd = {
									"mvn",
									"exec:java",
									"-Dexec.mainClass=" .. main_class,
									"-Dexec.args=",
								},
								components = {
									{ "on_output_quickfix", open = true },
									"default",
								},
							},
						} or nil,
					},
					"open_output",
					"default",
				},
			}
		end
	end,
	condition = {
		filetype = { "java" },
		callback = function()
			local dir = vim.fn.expand("%:p:h")
			return vim.fn.filereadable(dir .. "/pom.xml") == 1
		end,
	},
}
