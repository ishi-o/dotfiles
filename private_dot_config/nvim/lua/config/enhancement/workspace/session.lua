local ok, auto_session = pcall(require, "auto-session")
if ok then
	auto_session.setup({
		pre_save_cmds = {
			function()
				local ok2, overseer_task_list = pcall(require, "overseer.task_list")
				if ok2 then
					local tasks = overseer_task_list.list_tasks()
					local cmds = {}
					for _, task in ipairs(tasks) do
						local json = vim.json.encode(task:serialize())
						json = string.gsub(json, "\\/", "/")
						json = string.gsub(json, "'", "\\'")
						table.insert(
							cmds,
							string.format("lua require('overseer').new_task(vim.json.decode('%s')):start()", json)
						)
					end
					return cmds
				end
			end,
			function()
				local ok3, avante = pcall(require, "avante")
				if ok3 and avante then
					avante.close_sidebar()
				end
				return true
			end,
		},
		pre_restore_cmds = {
			function()
				local ok4, overseer = pcall(require, "overseer")
				if ok4 then
					for _, task in ipairs(overseer.list_tasks({})) do
						task:dispose(true)
					end
				end
			end,
		},
		suppress_dirs = {
			"~/",
			"~/opt",
			"~/tmp",
			"/tmp",
			"/",
		},
	})
end
