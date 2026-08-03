return {
	name = "Java",
	generator = function(opts, cb)
		local dir = opts.dir
		local root, tool, wrapper
		while true do
			if vim.fn.filereadable(dir .. "/mvnw") == 1 then
				root, tool, wrapper = dir, "maven", "./mvnw"
				break
			end
			if vim.fn.filereadable(dir .. "/gradlew") == 1 then
				root, tool, wrapper = dir, "gradle", "./gradlew"
				break
			end
			local parent = vim.fs.dirname(dir)
			if parent == dir then
				return "No mvnw or gradlew found"
			end
			dir = parent
		end

		local items = { { label = "Full build", value = "__full__" } }
		local paths = tool == "maven" and vim.fs.find("pom.xml", { upward = true, type = "file", path = root })
			or vim.fs.find({ "settings.gradle", "settings.gradle.kts" }, { upward = true, type = "file", path = root })
		local path = paths[1]
		if path then
			local lines = vim.fn.readfile(path)
			if tool == "maven" then
				local text = table.concat(lines, "\n")
				for module in text:gmatch("<module>%s*([^<%s]+)%s*</module>") do
					local item = module:gsub("^%s+", ""):gsub("%s+$", "")
					if item ~= "" then
						items[#items + 1] = { label = item, value = item }
					end
				end
			else
				for _, line in ipairs(lines) do
					if line:find("include", 1, true) then
						for module in line:gmatch("[\"']([^\"']+)[\"']") do
							local item = module:gsub("[,%s]+$", ""):gsub("^%s+", ""):gsub("%s+$", "")
							if item ~= "" and item ~= ":" then
								items[#items + 1] = { label = item:gsub("^:", ""), value = item }
							end
						end
					end
				end
			end
		end

		vim.ui.select(items, {
			prompt = "Java task",
			format_item = function(item)
				return item.label
			end,
		}, function(choice)
			if not choice then
				cb({})
				return
			end

			cb({
				{
					name = "Build",
					builder = function()
						return {
							cmd = wrapper,
							args = tool == "maven" and (choice.value == "__full__" and { "compile" } or {
								"-pl",
								choice.value,
								"-am",
								"compile",
							}) or (choice.value == "__full__" and { "compileJava" } or {
								choice.value .. ":compileJava",
							}),
							cwd = root,
							components = { "on_complete_notify", "default" },
						}
					end,
				},
				{
					name = "BuildRun",
					builder = function()
						return {
							cmd = wrapper,
							args = tool == "maven" and (choice.value == "__full__" and {
								"-Dmaven.test.skip=true",
								"spring-boot:run",
							} or {
								"-pl",
								choice.value,
								"-Dmaven.test.skip=true",
								"spring-boot:run",
							}) or (choice.value == "__full__" and { "bootRun", "-x", "test" } or {
								choice.value .. ":bootRun",
								"-x",
								"test",
							}),
							cwd = root,
							components = { "open_output", "default" },
						}
					end,
				},
			})
		end)
	end,
	condition = {
		filetype = { "java" },
	},
}
