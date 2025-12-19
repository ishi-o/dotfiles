require("auto-session").setup({
	pre_save_cmds = {
		function()
			local tasks = require("overseer.task_list").list_tasks()
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
		end,
	},
	pre_restore_cmds = {
		function()
			for _, task in ipairs(require("overseer").list_tasks({})) do
				task:dispose(true)
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
