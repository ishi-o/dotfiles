local M = {}

local codex_term = {
	bufnr = nil,
	winid = nil,
	jobid = nil,
	type = nil,
	win_config = nil,
	current_session_idx = nil,
}

local function get_session_list(cwd)
	local db = vim.fn.expand("~/.codex/state_5.sqlite")
	if vim.fn.filereadable(db) ~= 1 then
		return {}
	end
	local sql = string.format(
		"SELECT id, title FROM threads WHERE cwd = '%s' AND archived = 0 ORDER BY created_at DESC LIMIT 20",
		cwd
	)
	local output = vim.fn.system(string.format("sqlite3 '%s' \"%s\"", db, sql))
	if output == "" then
		return {}
	end
	local sessions = {}
	for line in output:gmatch("[^\n]+") do
		local id, title = line:match("^([^|]+)|(.*)$")
		if id and title then
			table.insert(sessions, { id = id, title = title })
		end
	end
	return sessions
end

local function start_codex(mode)
	local cwd = vim.fn.getcwd()

	if codex_term.bufnr and vim.api.nvim_buf_is_valid(codex_term.bufnr) then
		if codex_term.type ~= mode then
			if codex_term.jobid and codex_term.jobid > 0 then
				vim.fn.jobstop(codex_term.jobid)
			end
			vim.api.nvim_buf_delete(codex_term.bufnr, { force = true })
			codex_term.bufnr = nil
			codex_term.winid = nil
			codex_term.jobid = nil
		elseif codex_term.winid and vim.api.nvim_win_is_valid(codex_term.winid) then
			codex_term.win_config = vim.api.nvim_win_get_config(codex_term.winid)
			vim.api.nvim_win_hide(codex_term.winid)
			codex_term.winid = nil
			return
		else
			local config = codex_term.win_config
				or {
					vertical = true,
					width = math.floor(vim.o.columns * 0.4),
					win = 0,
					split = "right",
				}
			codex_term.winid = vim.api.nvim_open_win(codex_term.bufnr, true, config)
			return
		end
	end

	local width = math.floor(vim.o.columns * 0.4)

	codex_term.bufnr = vim.api.nvim_create_buf(false, true)
	vim.bo[codex_term.bufnr].bufhidden = "hide"

	codex_term.winid = vim.api.nvim_open_win(codex_term.bufnr, true, {
		vertical = true,
		width = width,
		win = 0,
		split = "right",
	})

	local codex_cmd = "codex"

	if mode == "last" then
		codex_cmd = "codex resume --last || codex"
		codex_term.current_session_idx = 1
	elseif mode == "prev" or mode == "next" then
		local sessions = get_session_list(cwd)
		if #sessions == 0 then
			vim.notify("No sessions available", vim.log.levels.WARN)
			vim.api.nvim_buf_delete(codex_term.bufnr, { force = true })
			codex_term.bufnr = nil
			codex_term.winid = nil
			return
		end
		local idx = codex_term.current_session_idx or 1
		if mode == "prev" then
			if idx < #sessions then
				codex_cmd = "codex resume " .. sessions[idx + 1].id
				codex_term.current_session_idx = idx + 1
			else
				vim.notify("No previous session", vim.log.levels.INFO)
				vim.api.nvim_buf_delete(codex_term.bufnr, { force = true })
				codex_term.bufnr = nil
				codex_term.winid = nil
				return
			end
		else
			if idx > 1 then
				codex_cmd = "codex resume " .. sessions[idx - 1].id
				codex_term.current_session_idx = idx - 1
			else
				vim.notify("No next session", vim.log.levels.INFO)
				vim.api.nvim_buf_delete(codex_term.bufnr, { force = true })
				codex_term.bufnr = nil
				codex_term.winid = nil
				return
			end
		end
	else
		codex_term.current_session_idx = nil
	end

	codex_term.type = mode
	codex_term.jobid = vim.fn.jobstart(codex_cmd, {
		pty = true,
		term = true,
		on_exit = function()
			if codex_term.bufnr and vim.api.nvim_buf_is_valid(codex_term.bufnr) then
				vim.api.nvim_buf_delete(codex_term.bufnr, { force = true })
			end
			codex_term.bufnr = nil
			codex_term.winid = nil
			codex_term.jobid = nil
			codex_term.type = nil
			codex_term.win_config = nil
		end,
	})

	vim.b[codex_term.bufnr].terminal_job_id = codex_term.jobid
end

local function pick_session()
	local cwd = vim.fn.getcwd()
	local sessions = get_session_list(cwd)
	if #sessions == 0 then
		vim.notify("No sessions found", vim.log.levels.INFO)
		return
	end

	local items = {}
	for i, s in ipairs(sessions) do
		table.insert(items, string.format("%d: %s", i, s.title))
	end

	vim.ui.select(items, {
		prompt = "Select Codex Session:",
	}, function(choice, idx)
		if not choice then
			return
		end
		local session_id = sessions[idx].id

		if codex_term.bufnr and vim.api.nvim_buf_is_valid(codex_term.bufnr) then
			if codex_term.jobid and codex_term.jobid > 0 then
				vim.fn.jobstop(codex_term.jobid)
			end
			vim.api.nvim_buf_delete(codex_term.bufnr, { force = true })
			codex_term.bufnr = nil
			codex_term.winid = nil
			codex_term.jobid = nil
		end

		local width = math.floor(vim.o.columns * 0.4)

		codex_term.bufnr = vim.api.nvim_create_buf(false, true)
		vim.bo[codex_term.bufnr].bufhidden = "hide"

		codex_term.winid = vim.api.nvim_open_win(codex_term.bufnr, true, {
			vertical = true,
			width = width,
			win = 0,
			split = "right",
		})

		codex_term.type = "pick"
		codex_term.current_session_idx = idx
		codex_term.jobid = vim.fn.jobstart("codex resume " .. session_id, {
			pty = true,
			term = true,
			on_exit = function()
				if codex_term.bufnr and vim.api.nvim_buf_is_valid(codex_term.bufnr) then
					vim.api.nvim_buf_delete(codex_term.bufnr, { force = true })
				end
				codex_term.bufnr = nil
				codex_term.winid = nil
				codex_term.jobid = nil
				codex_term.type = nil
				codex_term.win_config = nil
			end,
		})

		vim.b[codex_term.bufnr].terminal_job_id = codex_term.jobid
	end)
end

local function stop_codex()
	if codex_term.jobid and codex_term.jobid > 0 then
		vim.fn.jobstop(codex_term.jobid)
	end

	if codex_term.winid and vim.api.nvim_win_is_valid(codex_term.winid) then
		vim.api.nvim_win_close(codex_term.winid, true)
	end

	if codex_term.bufnr and vim.api.nvim_buf_is_valid(codex_term.bufnr) then
		vim.api.nvim_buf_delete(codex_term.bufnr, { force = true })
	end

	codex_term.bufnr = nil
	codex_term.winid = nil
	codex_term.jobid = nil
	codex_term.type = nil
	codex_term.win_config = nil
	codex_term.current_session_idx = nil
end

function M.setup()
	local cmd = vim.api.nvim_create_user_command

	cmd("Codex", function(opts)
		local arg = opts.args
		if arg == "stop" then
			stop_codex()
		elseif arg == "pick" then
			pick_session()
		else
			start_codex(arg)
		end
	end, {
		nargs = "?",
		complete = function()
			return { "new", "last", "pick", "prev", "next", "stop" }
		end,
	})
end

return M
