local M = {}
local IGNORE_ENVS = {
	[[\v\c^(.*_(proxy|api_key)|.*(PATH|_IM_MODULE)|(KITTY|ZPLUG|HOMEBREW|LC|XPC)_.*|(TERM|VIM).*|COLORTERM|COMMAND_MODE|DISPLAY|DOCKER_HOST|EDITOR|GDK_BACKEND|ZSH|VISUAL|LANG|LOGNAME|HOME|OLDPWD|PATH|PWD|SHELL|SHLVL|SSH_AUTH_SOCK|TMPDIR|USER|_.*)$]],
}

local function load_state(state_file)
	if vim.fn.filereadable(state_file) ~= 1 then
		return
	end
	local ok, decoded = pcall(vim.mpack.decode, table.concat(vim.fn.readfile(state_file, "b"), ""))
	if ok and type(decoded) == "table" then
		for k, v in pairs(decoded) do
			vim.env[k] = v
		end
	end
end

local function persist(state_file)
	local handle = io.open(state_file, "wb")
	if not handle then
		return
	end
	local env = {}
	for k, v in pairs(vim.fn.environ()) do
		env[k] = v
	end
	handle:write(tostring(vim.mpack.encode(env)))
	handle:close()
end

local function make_ignore_matcher(patterns)
	---@type vim.regex
	local regexes = {}
	for _, pattern in ipairs(patterns) do
		local ok, regex = pcall(vim.regex, pattern)
		if ok then
			regexes[#regexes + 1] = regex
		end
	end
	return function(value)
		for _, regex in ipairs(regexes) do
			if regex:match_str(value) then
				return true
			end
		end
		return false
	end
end

---@param opts? { ignore?: string[] }
function M.setup(opts)
	opts = opts or {}
	local is_ignored = make_ignore_matcher(opts.ignore or IGNORE_ENVS)
	local state_dir = vim.fn.stdpath("state") .. "/env_vars"
	local active_cwd = vim.fs.normalize(vim.fn.getcwd())
	local state_file = state_dir .. "/" .. vim.fn.sha256(active_cwd) .. ".mpack"
	vim.fn.mkdir(state_dir, "p")

	load_state(state_file)
	persist(state_file)

	vim.api.nvim_create_user_command("EnvVars", function()
		local cwd = vim.fs.normalize(vim.fn.getcwd())
		if cwd ~= active_cwd then
			active_cwd = cwd
			state_file = state_dir .. "/" .. vim.fn.sha256(active_cwd) .. ".mpack"
			load_state(state_file)
		end

		local items = {}
		for key, value in pairs(vim.fn.environ()) do
			if not is_ignored(key) then
				items[#items + 1] = { key = key, value = value }
			end
		end
		table.sort(items, function(a, b)
			return a.key < b.key
		end)
		table.insert(items, 1, { key = "Add new", value = "__add_new__" })
		vim.ui.select(items, {
			prompt = "Set environment variable",
			format_item = function(item)
				if item.value == "__add_new__" then
					return "Add new"
				end
				return item.key .. "=" .. item.value
			end,
		}, function(item)
			if not item then
				return
			end
			if item.value == "__add_new__" then
				vim.ui.input({ prompt = "Variable name:" }, function(name)
					if not name or name == "" then
						return
					end
					vim.ui.input({ prompt = "Variable value:" }, function(value)
						if value == nil then
							return
						end
						vim.env[name] = value
						persist(state_file)
					end)
				end)
				return
			end
			vim.ui.input({
				prompt = "Variable value:",
				default = item.value,
			}, function(value)
				if value == nil then
					return
				end
				vim.env[item.key] = value
				persist(state_file)
			end)
		end)
	end, { nargs = 0 })
end

return M
