-- snacks --
return {
	-- picker --
	{
		-- Top Pickers & Explorer
		{
			"<C-h>",
			function()
				Snacks.explorer()
			end,
			mode = { "n", "x", "i", "t" },
			desc = "Toggle: file explorer",
		},
		{
			"<leader><space>",
			function()
				Snacks.picker.smart()
			end,
			desc = "Smart Find Files",
		},
		{
			"<leader>,",
			function()
				Snacks.picker.buffers()
			end,
			desc = "Buffers",
		},
		{
			"<leader>/",
			function()
				Snacks.picker.grep()
			end,
			desc = "Grep",
		},
		{
			"<leader>:",
			function()
				Snacks.picker.command_history()
			end,
			desc = "Command History",
		},
		{
			"<leader>n",
			function()
				Snacks.picker.notifications()
			end,
			desc = "Notification History",
		},
		-- find
		{
			"<leader>fb",
			function()
				Snacks.picker.buffers()
			end,
			desc = "Buffers",
		},
		{
			"<leader>fc",
			function()
				Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
			end,
			desc = "Find Config File",
		},
		{
			"<leader>ff",
			function()
				Snacks.picker.files()
			end,
			desc = "Find Files",
		},
		{
			"<leader>fg",
			function()
				Snacks.picker.git_files()
			end,
			desc = "Find Git Files",
		},
		{
			"<leader>fP",
			function()
				Snacks.picker.projects()
			end,
			desc = "Projects",
		},
		{
			"<leader>fr",
			function()
				Snacks.picker.recent()
			end,
			desc = "Recent",
		},
		-- git
		{
			"<leader>gb",
			function()
				Snacks.picker.git_branches()
			end,
			desc = "Git Branches",
		},
		{
			"<leader>gl",
			function()
				Snacks.picker.git_log()
			end,
			desc = "Git Log",
		},
		{
			"<leader>gL",
			function()
				Snacks.picker.git_log_line()
			end,
			desc = "Git Log Line",
		},
		{
			"<leader>gs",
			function()
				Snacks.picker.git_status()
			end,
			desc = "Git Status",
		},
		{
			"<leader>gS",
			function()
				Snacks.picker.git_stash()
			end,
			desc = "Git Stash",
		},
		{
			"<leader>gd",
			function()
				Snacks.picker.git_diff()
			end,
			desc = "Git Diff (Hunks)",
		},
		{
			"<leader>gf",
			function()
				Snacks.picker.git_log_file()
			end,
			desc = "Git Log File",
		},
		-- gh
		{
			"<leader>gi",
			function()
				Snacks.picker.gh_issue()
			end,
			desc = "GitHub Issues (open)",
		},
		{
			"<leader>gI",
			function()
				Snacks.picker.gh_issue({ state = "all" })
			end,
			desc = "GitHub Issues (all)",
		},
		{
			"<leader>gp",
			function()
				Snacks.picker.gh_pr()
			end,
			desc = "GitHub Pull Requests (open)",
		},
		{
			"<leader>gP",
			function()
				Snacks.picker.gh_pr({ state = "all" })
			end,
			desc = "GitHub Pull Requests (all)",
		},
		-- Grep
		{
			"<leader>sb",
			function()
				Snacks.picker.lines()
			end,
			desc = "Buffer Lines",
		},
		{
			"<leader>sB",
			function()
				Snacks.picker.grep_buffers()
			end,
			desc = "Grep Open Buffers",
		},
		{
			"<leader>sg",
			function()
				Snacks.picker.grep()
			end,
			desc = "Grep",
		},
		{
			"<leader>sw",
			function()
				Snacks.picker.grep_word()
			end,
			desc = "Visual selection or word",
			mode = { "n", "x" },
		},
		-- search
		{
			'<leader>s"',
			function()
				Snacks.picker.registers()
			end,
			desc = "Registers",
		},
		{
			"<leader>s/",
			function()
				Snacks.picker.search_history()
			end,
			desc = "Search History",
		},
		{
			"<leader>sa",
			function()
				Snacks.picker.autocmds()
			end,
			desc = "Autocmds",
		},
		{
			"<leader>sb",
			function()
				Snacks.picker.lines()
			end,
			desc = "Buffer Lines",
		},
		{
			"<leader>sc",
			function()
				Snacks.picker.command_history()
			end,
			desc = "Command History",
		},
		{
			"<leader>sC",
			function()
				Snacks.picker.commands()
			end,
			desc = "Commands",
		},
		{
			"<leader>sd",
			function()
				Snacks.picker.diagnostics()
			end,
			desc = "Diagnostics",
		},
		{
			"<leader>sD",
			function()
				Snacks.picker.diagnostics_buffer()
			end,
			desc = "Buffer Diagnostics",
		},
		{
			"<leader>sh",
			function()
				Snacks.picker.help()
			end,
			desc = "Help Pages",
		},
		{
			"<leader>sH",
			function()
				Snacks.picker.highlights()
			end,
			desc = "Highlights",
		},
		{
			"<leader>si",
			function()
				Snacks.picker.icons()
			end,
			desc = "Icons",
		},
		{
			"<leader>sj",
			function()
				Snacks.picker.jumps()
			end,
			desc = "Jumps",
		},
		{
			"<leader>sk",
			function()
				Snacks.picker.keymaps()
			end,
			desc = "Keymaps",
		},
		{
			"<leader>sl",
			function()
				Snacks.picker.loclist()
			end,
			desc = "Location List",
		},
		{
			"<leader>sm",
			function()
				Snacks.picker.marks()
			end,
			desc = "Marks",
		},
		{
			"<leader>sM",
			function()
				Snacks.picker.man()
			end,
			desc = "Man Pages",
		},
		{
			"<leader>sp",
			function()
				Snacks.picker.lazy()
			end,
			desc = "Search for Plugin Spec",
		},
		{
			"<leader>sq",
			function()
				Snacks.picker.qflist()
			end,
			desc = "Quickfix List",
		},
		{
			"<leader>sR",
			function()
				Snacks.picker.resume()
			end,
			desc = "Resume",
		},
		{
			"<leader>su",
			function()
				Snacks.picker.undo()
			end,
			desc = "Undo History",
		},
		{
			"<leader>uC",
			function()
				Snacks.picker.colorschemes()
			end,
			desc = "Colorschemes",
		},
		-- LSP
		{
			"gd",
			function()
				Snacks.picker.lsp_definitions()
			end,
			desc = "Goto: definition",
		},
		{
			"gD",
			function()
				Snacks.picker.lsp_declarations()
			end,
			desc = "Goto: declaration",
		},
		{
			"gr",
			function()
				Snacks.picker.lsp_references()
			end,
			nowait = true,
			desc = "Goto: references",
		},
		{
			"gI",
			function()
				Snacks.picker.lsp_implementations()
			end,
			desc = "Goto: implementation",
		},
		{
			"gy",
			function()
				Snacks.picker.lsp_type_definitions()
			end,
			desc = "Goto: type definition",
		},
		{
			"gai",
			function()
				Snacks.picker.lsp_incoming_calls()
			end,
			desc = "Show: incoming calls",
		},
		{
			"gao",
			function()
				Snacks.picker.lsp_outgoing_calls()
			end,
			desc = "Show: outgoing calls",
		},
		-- {
		-- 	"<leader>ss",
		-- 	function()
		-- 		Snacks.picker.lsp_symbols()
		-- 	end,
		-- 	desc = "LSP Workspace Symbols",
		-- },
		{
			"<leader>sS",
			function()
				Snacks.picker.lsp_workspace_symbols()
			end,
			desc = "LSP Workspace Symbols",
		},
	},

	-- words --
	{
		"]]",
		function()
			Snacks.words.jump(vim.v.count1)
		end,
		desc = "Next Reference",
		mode = { "n", "t" },
	},
	{
		"[[",
		function()
			Snacks.words.jump(-vim.v.count1)
		end,
		desc = "Prev Reference",
		mode = { "n", "t" },
	},
	{
		"[f",
		function()
			Snacks.scope.jump({
				bottom = false,
				edge = true,
				min_size = 1,
				cursor = false,
				treesitter = {
					blocks = {
						enabled = true,
						"function_definition",
						"method_definition",
						"function_declaration",
						"method_declaration",
					},
				},
			})
		end,
		desc = "Jump to top edge of function",
		mode = { "n" },
	},
	{
		"]f",
		function()
			Snacks.scope.jump({
				bottom = true,
				edge = true,
				min_size = 1,
				cursor = false,
				treesitter = {
					blocks = {
						enabled = true,
						"function_definition",
						"method_definition",
						"function_declaration",
						"method_declaration",
					},
				},
			})
		end,
		desc = "Jump to bottom edge of function",
		mode = { "n" },
	},
	{
		"if",
		function()
			Snacks.scope.textobject({
				min_size = 2,
				edge = false,
				cursor = false,
				treesitter = {
					blocks = {
						enabled = true,
						"function_definition",
						"method_definition",
						"function_declaration",
						"method_declaration",
					},
				},
			})
		end,
		desc = "Inner function",
		mode = { "x", "o" },
	},
	{
		"af",
		function()
			Snacks.scope.textobject({
				min_size = 2,
				cursor = false,
				treesitter = {
					blocks = {
						enabled = true,
						"function_definition",
						"method_definition",
						"function_declaration",
						"method_declaration",
					},
				},
			})
		end,
		desc = "Around function",
		mode = { "x", "o" },
	},
	{
		"ic",
		function()
			Snacks.scope.textobject({
				min_size = 2,
				edge = false,
				cursor = false,
				treesitter = { blocks = { enabled = true, "class_definition", "class_declaration" } },
			})
		end,
		desc = "Inner class",
		mode = { "x", "o" },
	},
	{
		"ac",
		function()
			Snacks.scope.textobject({
				min_size = 2,
				cursor = false,
				treesitter = { blocks = { enabled = true, "class_definition", "class_declaration" } },
			})
		end,
		desc = "Around class",
		mode = { "x", "o" },
	},
	{
		"it",
		function()
			Snacks.scope.textobject({
				min_size = 2,
				edge = false,
				cursor = false,
				treesitter = { blocks = { enabled = true, "if_statement" } },
			})
		end,
		desc = "Inner if-statement",
		mode = { "x", "o" },
	},
	{
		"at",
		function()
			Snacks.scope.textobject({
				min_size = 2,
				cursor = false,
				treesitter = { blocks = { enabled = true, "if_statement" } },
			})
		end,
		desc = "Around if-statement",
		mode = { "x", "o" },
	},
	{
		"il",
		function()
			Snacks.scope.textobject({
				min_size = 2,
				edge = false,
				cursor = false,
				treesitter = {
					blocks = {
						enabled = true,
						"for_statement",
						"while_statement",
						"do_statement",
						"repeat_statement",
					},
				},
			})
		end,
		desc = "Inner loop",
		mode = { "x", "o" },
	},
	{
		"al",
		function()
			Snacks.scope.textobject({
				min_size = 2,
				cursor = false,
				treesitter = {
					blocks = {
						enabled = true,
						"for_statement",
						"while_statement",
						"do_statement",
						"repeat_statement",
					},
				},
			})
		end,
		desc = "Around loop",
		mode = { "x", "o" },
	},
}
