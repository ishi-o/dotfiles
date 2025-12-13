local wk = require("which-key")

local quit = function()
	local win_count = vim.fn.winnr("$")
	local buf_count = #vim.fn.getbufinfo({ buflisted = 1 })
	local tab_count = #vim.fn.gettabinfo()
	if win_count > 1 then
		vim.cmd("q")
	elseif buf_count > 1 then
		vim.cmd("bp | bd #")
	elseif tab_count > 1 then
		vim.cmd("tabclose")
	else
		-- vim.cmd("qa")
		-- vim.cmd("bd")
		Snacks.dashboard()
	end
end

local harpoon_extra_keys = {}
for i = 1, 9 do
	table.insert(harpoon_extra_keys, {
		"<leader>" .. i,
		function()
			require("harpoon"):list():select(i)
		end,
		desc = "Harpoon to File " .. i,
	})
end

wk.setup({
	-- window shape --
	win = {
		border = "rounded",
		row = math.huge,
		col = math.huge,
		width = 0.3,
		height = 0.9,
		no_overlap = true,
	},
	max_description_length = 30,
	show = {
		delay = 600,
	},
})

wk.add({
	-- which-key --
	{
		"<C-_>", -- equivalent to Ctrl+/ --
		function()
			wk.show({ global = false })
		end,
		mode = { "n", "x", "i", "c", "o", "t" },
		desc = "Buffer Local Keymaps",
	},

	--project --
	{
		{ "<leader>p", "", group = "project" },

		{ "<leader>pp", "<cmd>lua require'telescope'.extensions.projects.projects{}<CR>", desc = "List Projects" },
	},

	-- session --
	{
		{ "<leader>sl", "<cmd>AutoSession search<CR>", desc = "List Session" },
	},

	-- refactor --
	{
		{ "<leader>r", "", group = "refactor", mode = { "n", "x" } },

		{
			"<leader>rr",
			'<cmd>lua require("telescope").extensions.refactoring.refactors()<CR>',
			mode = { "n", "x" },
		},
		{
			"<leader>ri",
			'<cmd>lua require("refactoring").refactor("Inline Variable")<CR>',
			mode = { "n", "x" },
			desc = "Inline Variable",
			expr = true,
		},
		{
			"<leader>rb",
			'<cmd>lua require("refactoring").refactor("Extract Block")<CR>',
			mode = { "n", "x" },
			desc = "Extract Block",
			expr = true,
		},
		{
			"<leader>rf",
			'<cmd>lua require("refactoring").refactor("Extract Block To File")<CR>',
			mode = { "n", "x" },
			desc = "Extract Block To File",
			expr = true,
		},
		{
			"<leader>rP",
			'<cmd>lua require("refactoring").debug.printf({ below = false })<CR>',
			desc = "Debug Print",
		},
		{
			"<leader>rp",
			'<cmd>lua require("refactoring").debug.print_var({ normal = true })<CR>',
			mode = { "n", "x" },
			desc = "Debug Print Variable",
		},
		{
			"<leader>rc",
			'<cmd>lua require("refactoring").debug.cleanup({})<CR>',
			desc = "Debug Cleanup",
		},
		{
			"<leader>rf",
			'<cmd>lua require("refactoring").refactor("Extract Function")<CR>',
			mode = { "n", "x" },
			desc = "Extract Function",
			expr = true,
		},
		{
			"<leader>rF",
			'<cmd>lua require("refactoring").refactor("Extract Function To File")<CR>',
			mode = { "n", "x" },
			desc = "Extract Function To File",
			expr = true,
		},
		{
			"<leader>rx",
			'<cmd>lua require("refactoring").refactor("Extract Variable")<CR>',
			mode = { "n", "x" },
			desc = "Extract Variable",
			expr = true,
		},
		{
			"<leader>rp",
			'<cmd>lua require("refactoring").debug.print_var()<CR>',
			mode = { "n", "x" },
			desc = "Debug Print Variable",
		},
	},

	-- pin --
	{
		{
			"<leader>M",
			'<cmd>lua require("harpoon"):list():add()<CR>',
			desc = "Harpoon File",
		},
		{
			"<leader>mp",
			"<cmd>Telescope harpoon marks<CR>",
			-- function()
			-- 	local harpoon = require("harpoon")
			-- 	harpoon.ui:toggle_quick_menu(harpoon:list())
			-- end,
			desc = "Harpoon Quick Menu",
		},
		harpoon_extra_keys,
	},

	-- outline --
	{
		{ "<leader>o", "<cmd>AerialToggle<cr>", desc = "Aerial (Symbols)" },
	},

	-- todo-comments --
	{
		{
			"]t",
			"<cmd>lua require('todo-comments').jump_next()<CR>",
			desc = "Next Todo Comment",
		},
		{
			"[t",
			"<cmd>lua require('todo-comments').jump_prev()<CR>",
			desc = "Previous Todo Comment",
		},
		{ "<leader>xt", "<cmd>Trouble todo toggle<cr>", desc = "Todo (Trouble)" },
		{
			"<leader>xT",
			"<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>",
			desc = "Todo/Fix/Fixme (Trouble)",
		},
		{ "<leader>st", "<cmd>TodoTelescope<CR>", desc = "Todo" },
		{ "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<CR>", desc = "Todo/Fix/Fixme" },
	},

	-- toggleterm --
	{
		group = "toggleterm",
		{ "<C-q>", "<C-\\><C-n>", mode = "t", desc = "[Q]uit terminal mode" },
		{ "<C-t>", desc = "[T]oggle terminal" },
	},

	-- autolist --
	-- see ~/.config/nvim/after/ftplugin/markdown.lua

	{
		{ "<leader>md", "<cmd>MarkdownPreview<CR>", desc = "MarkdownPreview" },
	},

	-- codecompanion --
	{
		{ "<leader>a", group = "codecompanion" },

		{ "<leader>ac", "<cmd>CodeCompanionChat<CR>", desc = "[A]i [C]hat" },
		{ "<leader>aa", "<cmd>CodeCompanionActions<CR>", desc = "[A]i [A]ctions" },
	},

	-- code map --
	{
		{ "<leader>m", group = "code map" },

		{
			"<leader>mo",
			'<cmd>lua require("codewindow").open_minimap()<CR>',
			desc = "Open minimap",
		},
		{
			"<leader>mf",
			'<cmd>lua require("codewindow").toggle_focus()<CR>',
			desc = "Toggle minimap focus",
		},
		{
			"<leader>mc",
			'<cmd>lua require("codewindow").close_minimap()<CR>',
			desc = "Close minimap",
		},
		{
			"<leader>mm",
			'<cmd>lua require("codewindow").toggle_minimap()<CR>',
			desc = "Toggle minimap",
		},
	},

	-- neo-tree --
	{
		group = "neo-tree",

		-- { "<C-h>", "<cmd>Neotree toggle<CR>", mode = { "n", "x", "i", "t" }, desc = "Toggle file tree" },
	},

	-- github --
	{
		{ "<leader>gh", group = "Github" },

		{ "<leader>ghc", group = "Commits" },
		{ "<leader>ghcc", "<cmd>GHCloseCommit<CR>", desc = "Close" },
		{ "<leader>ghce", "<cmd>GHExpandCommit<CR>", desc = "Expand" },
		{ "<leader>ghco", "<cmd>GHOpenToCommit<CR>", desc = "Open To" },
		{ "<leader>ghcp", "<cmd>GHPopOutCommit<CR>", desc = "Pop Out" },
		{ "<leader>ghcz", "<cmd>GHCollapseCommit<CR>", desc = "Collapse" },

		{ "<leader>ghi", group = "Issues" },
		{ "<leader>ghip", "<cmd>GHPreviewIssue<CR>", desc = "Preview" },

		{ "<leader>ghl", group = "Litee" },
		{ "<leader>ghlt", "<cmd>LTPanel<CR>", desc = "Toggle Panel" },

		{ "<leader>ghp", group = "Pull Request" },
		{ "<leader>ghpc", "<cmd>GHClosePR<CR>", desc = "Close" },
		{ "<leader>ghpd", "<cmd>GHPRDetails<CR>", desc = "Details" },
		{ "<leader>ghpe", "<cmd>GHExpandPR<CR>", desc = "Expand" },
		{ "<leader>ghpo", "<cmd>GHOpenPR<CR>", desc = "Open" },
		{ "<leader>ghpp", "<cmd>GHPopOutPR<CR>", desc = "PopOut" },
		{ "<leader>ghpr", "<cmd>GHRefreshPR<CR>", desc = "Refresh" },
		{ "<leader>ghpt", "<cmd>GHOpenToPR<CR>", desc = "Open To" },
		{ "<leader>ghpz", "<cmd>GHCollapsePR<CR>", desc = "Collapse" },

		{ "<leader>ghr", group = "Review" },
		{ "<leader>ghrb", "<cmd>GHStartReview<CR>", desc = "Begin" },
		{ "<leader>ghrc", "<cmd>GHCloseReview<CR>", desc = "Close" },
		{ "<leader>ghrd", "<cmd>GHDeleteReview<CR>", desc = "Delete" },
		{ "<leader>ghre", "<cmd>GHExpandReview<CR>", desc = "Expand" },
		{ "<leader>ghrs", "<cmd>GHSubmitReview<CR>", desc = "Submit" },
		{ "<leader>ghrz", "<cmd>GHCollapseReview<CR>", desc = "Collapse" },

		{ "<leader>ght", group = "Threads" },
		{ "<leader>ghtc", "<cmd>GHCreateThread<CR>", desc = "Create" },
		{ "<leader>ghtn", "<cmd>GHNextThread<CR>", desc = "Next" },
		{ "<leader>ghtt", "<cmd>GHToggleThread<CR>", desc = "Toggle" },
	},

	-- snacks --
	{
		{
			"<C-h>",
			function()
				Snacks.explorer()
			end,
			mode = { "n", "x", "i", "t" },
			desc = "Toggle file explorer",
		},
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
			desc = "jump to top edge of function",
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
			desc = "jump to bottom edge of function",
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
			desc = "inner function",
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
			desc = "around function",
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
			desc = "inner class",
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
			desc = "around class",
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
			desc = "inner if-statement",
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
			desc = "around if-statement",
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
			desc = "inner for-loop",
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
			desc = "around for-loop",
			mode = { "x", "o" },
		},
	},

	-- flash --
	{
		group = "flash",

		{
			"s",
			function()
				require("flash").jump()
			end,
			mode = { "n", "x", "o" },
			desc = "search and jump",
		},
		{
			"S",
			function()
				require("flash").treesitter()
			end,
			mode = { "n", "x", "o" },
			desc = "search block by treesitter",
		},
		{
			"r",
			function()
				require("flash").remote()
			end,
			mode = "o",
			desc = "Remote operator mode (jump -> op -> back)",
		},
		{
			"R",
			function()
				require("flash").treesitter_search()
			end,
			mode = { "o", "x" },
			desc = "remote search block by treesitter",
		},
		{
			"<C-s>",
			function()
				require("flash").toggle()
			end,
			mode = "c",
			desc = "toggle flash",
		},
	},

	-- dial --
	{
		group = "dial",

		{
			"<C-a>",
			'<cmd>lua require("dial.map").manipulate("increment", "normal")<CR>',
			desc = "Increment constants",
		},
		{
			"<C-x>",
			'<cmd>lua require("dial.map").manipulate("decrement", "normal")<CR>',
			desc = "Decrement constants",
		},
		{
			"g<C-a>",
			'<cmd>lua require("dial.map").manipulate("increment", "gnormal")<CR>',
			desc = "Sequence Increment constants",
		},
		{
			"g<C-x>",
			'<cmd>lua require("dial.map").manipulate("decrement", "gnormal")<CR>',
			desc = "Sequence Decrement constants",
		},
		{
			"<C-a>",
			'<cmd>lua require("dial.map").manipulate("increment", "visual")<CR>',
			mode = "x",
			desc = "Increment constants",
		},
		{
			"<C-x>",
			'<cmd>lua require("dial.map").manipulate("decrement", "visual")<CR>',
			mode = "x",
			desc = "Decrement constants",
		},
		{
			"g<C-a>",
			'<cmd>lua require("dial.map").manipulate("increment", "gvisual")<CR>',
			mode = "x",
			desc = "Sequence Increment constants",
		},
		{
			"g<C-x>",
			'<cmd>lua require("dial.map").manipulate("decrement", "gvisual")<CR>',
			mode = "x",
			desc = "Sequence Decrement constants",
		},
	},

	-- telescope --
	{
		{ "<leader>f", group = "telescope" },

		{ "<leader>fd", require("telescope.builtin").find_files, desc = "[F]in[d] files" },
		{ "<leader>fg", require("telescope.builtin").live_grep, desc = "[F]ind by [G]reps" },
		{ "<leader>fb", require("telescope.builtin").buffers, desc = "[F]ind [B]uffers" },
		{ "<leader>fo", require("telescope.builtin").oldfiles, desc = "[F]ind [O]ldfiles" },
		{ "<leader>fe", "<cmd>Telescope file_browser<CR>", desc = "[F]ile [E]xplorer" },
		{ "<C-?>", require("telescope.builtin").help_tags, desc = "Telescope help tags" },
	},

	-- complete --
	{
		group = "complete",
		mode = "i",

		{ "<Tab>", desc = "Confirm complete" },
		{ "<A-k>", desc = "Previow complete item" },
		{ "<A-j>", desc = "Next complete item" },
	},

	-- git --
	{
		{ "<leader>g", group = "git" },

		{ "<leader>gg", "<cmd>Neogit<CR>", desc = "Show Neogit UI" },
	},

	-- trouble.nvim --
	{
		{ "<leader>x", group = "diagnostics" },

		{ "<leader>xx", "<cmd>Trouble diagnostics toggle<CR>", desc = "Diagnostics (Trouble)" },
		{
			"<leader>xX",
			"<cmd>Trouble diagnostics toggle filter.buf=0<CR>",
			desc = "Buffer Diagnostics (Trouble)",
		},
		{
			"<leader>xs",
			"<cmd>Trouble symbols toggle focus=false<CR>",
			desc = "Symbols (Trouble)",
		},
		{
			"<leader>xl",
			"<cmd>Trouble lsp toggle focus=false win.position=right<CR>",
			desc = "LSP Definitions / references / ... (Trouble)",
		},
		{ "<leader>xL", "<cmd>Trouble loclist toggle<CR>", desc = "Location List (Trouble)" },
		{ "<leader>xQ", "<cmd>Trouble qflist toggle<CR>", desc = "Quickfix List (Trouble)" },
	},

	-- database --
	{
		{ "<leader>D", group = "database" },

		{ "<leader>D", "<cmd>DBUIToggle<CR>", desc = "Toggle Database UI" },
	},

	-- tasks --
	{
		group = "tasks",

		{ "<F4>", "<cmd>OverseerRun Build<CR>", desc = "Build" },
		{ "<F5>", "<cmd>OverseerRun Build & Run<CR>", desc = "Build & Run" },
	},

	-- debug --
	{
		{ "<leader>d", group = "debug" },

		{ "<F5>", '<cmd>lua require("dap").continue()<CR>', desc = "Debug: Run / Continue" },
		-- <S-F5>
		{ "<F17>", '<cmd>lua require("dap").terminate()<CR>', desc = "Debug: Terminate" },
		-- <C-S-F5>
		{ "<F41>", '<cmd>lua require("dap").run_last()<CR>', desc = "Debug: Run last" },
		{ "<F6>", '<cmd>lua require("dap").pause()<CR>', desc = "Debug: Pause" },
		-- { "<F9>", '<cmd>lua require("dap").toggle_breakpoint()<CR>', desc = "Debug: Toggle Breakpoint" },
		{
			"<F9>",
			"<cmd>lua require('persistent-breakpoints.api').toggle_breakpoint()<CR>",
			desc = "Debug: Toggle Breakpoint",
		},
		{ "<F10>", '<cmd>lua require("dap").step_over()<CR>', desc = "Debug: Step Over" },
		{ "<F11>", '<cmd>lua require("dap").step_into()<CR>', desc = "Debug: Step Into" },
		-- <S-F11>
		{ "<F23>", '<cmd>lua require("dap").step_out()<CR>', desc = "Debug: Step Out" },
		{
			"<leader>db",
			"<cmd>lua require('persistent-breakpoints.api').toggle_breakpoint()<CR>",
			desc = "Debug: Toggle Breakpoint",
		},
		{
			"<leader>dB",
			"<cmd>lua require('persistent-breakpoints.api').set_conditional_breakpoint()<CR>",
			desc = "Debug: Breakpoint Condition",
		},
		{ "<leader>dc", '<cmd>lua require("dap").continue()<CR>', desc = "Debug: Run / Continue" },
		{ "<leader>dl", '<cmd>lua require("dap").run_last()<CR>', desc = "Debug: Run last" },
		{ "<leader>dC", '<cmd>lua require("dap").run_to_cursor()<CR>', desc = "Debug: Run to cursor" },
		{ "<leader>di", '<cmd>lua require("dap").step_into()<CR>', desc = "Debug: Step Into" },
		{ "<leader>do", '<cmd>lua require("dap").step_over()<CR>', desc = "Debug: Step Over" },
		{ "<leader>dO", '<cmd>lua require("dap").step_out()<CR>', desc = "Debug: Step Out" },
		{ "<leader>dt", '<cmd>lua require("dap").terminate()<CR>', desc = "Debug: Terminate" },
		{ "<leader>dp", '<cmd>lua require("dap").pause()<CR>', desc = "Debug: Pause" },
		{ "<leader>dx", '<cmd>lua require("dap").disconnect()<CR>', desc = "Debug: Disconnect" },
		{ "<leader>dq", '<cmd>lua require("dap").close()<CR>', desc = "Debug: Close REPL" },
		{ "<leader>dr", '<cmd>lua require("dap").restart()<CR>', desc = "Debug: Restart" },
		{ "<leader>dj", '<cmd>lua require("dap").down()<CR>', desc = "Debug: Down Frame" },
		{ "<leader>dk", '<cmd>lua require("dap").up()<CR>', desc = "Debug: Up Frame" },
	},

	-- lsp --
	{
		group = "lsp",

		{ "gd", desc = "[G]o to [D]efinition" },
		{ "gi", desc = "[G]o to [I]mplementation" },
		{ "gr", desc = "[G]o to [R]eference" },
		{ "K", desc = "Show documentation" },
		{
			"gK",
			function()
				local current_config = vim.diagnostic.config().virtual_lines
				local new_config
				if current_config == false then
					new_config = { current_line = true }
				else
					new_config = false
				end
				vim.diagnostic.config({ virtual_lines = new_config })
			end,
			desc = "Toggle diagnostic (virtual lines)",
		},
		{
			"gk",
			function()
				vim.diagnostic.open_float({ focus = true, focus_id = "diagnostic_popup" })
			end,
			desc = "Toggle diagnostic (float)",
		},
		{ "<F2>", desc = "[R]e[n]ame" },
		{ "<leader>rn", desc = "[R]e[n]ame" },
		{ "<leader>C", desc = "[C]ode actions" },
	},

	-- substitute --
	{
		{ "g", group = "substitute" },

		{ "gs", '<cmd>lua require("substitute").operator()<CR>', desc = "Substitude in operator mode" },
		{ "gss", '<cmd>lua require("substitute").line()<CR>', desc = "Substitude curr line" },
		{ "gS", '<cmd>lua require("substitute").eol()<CR>', desc = "Substitude to eol" },
		{ "gs", '<cmd>lua require("substitute").visual()<CR>', mode = "x", desc = "Substitude in visual mode" },
	},

	-- httpclient --
	{
		{ "<leader>R", group = "Http Client" },

		{ "<leader>Rs", desc = "Send request" },
		{ "<leader>Ra", desc = "Send all requests" },
		{ "<leader>Rb", desc = "Open scratchpad" },
	},

	-- grup-far or spectre --
	{
		{ "<leader>s", group = "search and replace" },

		{
			"<leader>ss",
			function()
				local grug = require("grug-far")
				local ext = vim.bo.buftype == "" and vim.fn.expand("%:e")
				grug.open({
					transient = true,
					prefills = {
						filesFilter = ext and ext ~= "" and "*." .. ext or nil,
					},
				})
			end,
			mode = { "n", "x" },
			desc = "Search and Replace",
		},
		-- { "<leader>ss", '<cmd>lua require("spectre").toggle()<CR>', desc = "Toggle Spectre" },
		-- {
		-- 	"<leader>sw",
		-- 	'<cmd>lua require("spectre").open_visual({select_word=true})<CR>',
		-- 	desc = "Search current word",
		-- },
		-- { "<leader>sw", '<esc><cmd>lua require("spectre").open_visual()<CR>', desc = "Search current word" },
		-- {
		-- 	"<leader>sp",
		-- 	'<cmd>lua require("spectre").open_file_search({select_word=true})<CR>',
		-- 	desc = "Search on current file",
		-- },
	},

	-- local keybind --
	{
		group = "local",
		cond = function()
			return not vim.g.vscode
		end,

		-- change mode --
		-- Using <C-c> in insert mode breaks neo-tree
		{ "jj", "<Esc>", mode = "i", desc = "Return to normal mode" },
		-- <Esc> in command mode has some issues
		{ "jj", "<C-c>", mode = "c", desc = "Return to normal mode" },

		-- save --
		{ "<leader>s", "<cmd>w<CR>", desc = "[S]ave file" },

		-- quit --
		{ "<leader>z", "<cmd>qa<CR>", desc = "Quit neovim" },
		{ "z<leader>", "<cmd>qa<CR>", desc = "Quit neovim" },
		{ "<leader>q", quit, desc = "Quit file" },
		{ "q<leader>", quit, desc = "Quit file" },

		-- tab --
		{ "<leader>T", ":tabnew<Space>", desc = "New[T]ab (input filename)" },
		{ "<leader>B", "<cmd>tabprevious<CR>", desc = "Previous tab" },
		{ "<leader>N", "<cmd>tabnext<CR>", desc = "[N]ext tab" },

		-- buffer
		{ "<leader>t", ":edit<Space>", desc = "NewBuffer (input filename)" },
		{ "<leader>b", "<cmd>BufferLineCyclePrev<CR>", desc = "Previous Buffer" },
		{ "<leader>n", "<cmd>BufferLineCycleNext<CR>", desc = "[N]ext Buffer" },

		-- window --
		{ "<leader>V", ":split<Space>", desc = "Horizontal Split (input filename)" },
		{ "<leader>v", ":vsplit<Space>", desc = "Vertical Split (input filename)" },

		{ "<leader>h", "<cmd>wincmd h<CR>", desc = "Focus on the left page" },
		{ "<leader>j", "<cmd>wincmd j<CR>", desc = "Focus on the page below" },
		{ "<leader>k", "<cmd>wincmd k<CR>", desc = "Focus on the page above" },
		{ "<leader>l", "<cmd>wincmd l<CR>", desc = "Focus on the right page" },

		{ "<A-h>", require("smart-splits").resize_left, desc = "Window resize left" },
		{ "<A-j>", require("smart-splits").resize_down, desc = "Window resize down" },
		{ "<A-k>", require("smart-splits").resize_up, desc = "Window resize up" },
		{ "<A-l>", require("smart-splits").resize_right, desc = "Window resize right" },

		{ "<leader>H", require("smart-splits").swap_buf_left, desc = "Window swap left" },
		{ "<leader>J", require("smart-splits").swap_buf_down, desc = "Window swap down" },
		{ "<leader>K", require("smart-splits").swap_buf_up, desc = "Window swap up" },
		{ "<leader>L", require("smart-splits").swap_buf_right, desc = "Window swap right" },

		-- exchange line --
		{ "<C-j>", "<cmd>m+1<CR>==", desc = "Exchange currline and nextline" },
		{ "<C-k>", "<cmd>m-2<CR>==", desc = "Exchange currline and lastline" },
		{
			"<C-j>",
			function()
				if vim.fn.mode() ~= "V" then
					return
				end
				local start_line = vim.fn.line("v")
				local end_line = vim.fn.line(".")
				if start_line > end_line then
					start_line, end_line = end_line, start_line
				end
				local num_lines = end_line - start_line + 1
				local last_buf_line = vim.api.nvim_buf_line_count(0)
				if end_line >= last_buf_line then
					return
				end
				vim.cmd(string.format("silent %d,%dmove %d", start_line, end_line, end_line + 1))
				local new_start_line = start_line + 1
				local new_end_line = new_start_line + num_lines - 1
				vim.fn.setpos("'<", { 0, new_start_line, 1, 0 })
				vim.fn.setpos("'>", { 0, new_end_line, 2147483647, 0 })
				vim.cmd("normal! gv")
			end,
			mode = "x",
			desc = "Move selected lines down (VISUAL LINE, no clipboard)",
		},
		{
			"<C-k>",
			function()
				if vim.fn.mode() ~= "V" then
					return
				end
				local start_line = vim.fn.line("v")
				local end_line = vim.fn.line(".")
				if start_line > end_line then
					start_line, end_line = end_line, start_line
				end
				local num_lines = end_line - start_line + 1
				if start_line <= 1 then
					return
				end
				vim.cmd(string.format("silent %d,%dmove %d", start_line, end_line, start_line - 2))
				local new_start_line = start_line - 1
				local new_end_line = new_start_line + num_lines - 1
				vim.fn.setpos("'<", { 0, new_start_line, 1, 0 })
				vim.fn.setpos("'>", { 0, new_end_line, 2147483647, 0 })
				vim.cmd("normal! gv")
			end,
			mode = "x",
			desc = "Move selected lines up (VISUAL LINE, no clipboard)",
		},

		-- copy --
		{ "<C-c>", '"+y', mode = "x", desc = "Copy selected chars" },
		{ "<C-c>", '"+yy', mode = { "n", "i" }, desc = "Copy current line" },
	},

	-- vscode-neovim keybind --
	{
		group = "vscode",
		cond = function()
			return vim.g.vscode
		end,

		{ "jj", "<cmd>call VSCodeNotify('<C-c>')<CR>", mode = { "i", "c" }, desc = "Return to normal mode" },
		{ "<leader>s", "<cmd>call VSCodeNotify('workbench.action.files.save')<CR>", desc = "Save file" },
		{ "<leader>z", "<cmd>call VSCodeNotify('workbench.action.quit')<CR>", desc = "Quit neovim" },
		{
			"<leader>q",
			"<cmd>call VSCodeNotify('workbench.action.closeActiveEditor')<CR>",
			desc = "Close file",
		},

		{ "<leader>t", ":edit<Space>", desc = "New buffer (input filename)" },
		{ "<leader>T", ":tabnew<Space>", desc = "New tab (input filename)" },
		{
			"<leader>B",
			"<cmd>call VSCodeNotify('workbench.action.previousEditor')<CR>",
			desc = "Previous tab",
		},
		{ "<leader>N", "<cmd>call VSCodeNotify('workbench.action.nextEditor')<CR>", desc = "Next tab" },
		{
			"<leader>b",
			"<cmd>call VSCodeNotify('workbench.action.previousEditor')<CR>",
			desc = "Previous buffer",
		},
		{ "<leader>n", "<cmd>call VSCodeNotify('workbench.action.nextEditor')<CR>", desc = "Next buffer" },

		{
			"<A-j>",
			"<cmd>call VSCodeNotify('editor.action.moveLinesDownAction')<CR>",
			desc = "Move line down",
		},
		{ "<A-k>", "<cmd>call VSCodeNotify('editor.action.moveLinesUpAction')<CR>", desc = "Move line up" },

		{ "<leader>p", ":split<Space>", desc = "Horizontal split (input filename)" },
		{ "<leader>v", ":vsplit<Space>", desc = "Vertical split (input filename)" },

		{
			"<leader>h",
			"<cmd>call VSCodeNotify('workbench.action.focusLeftGroup')<CR>",
			desc = "Focus left window",
		},
		{
			"<leader>j",
			"<cmd>call VSCodeNotify('workbench.action.focusBelowGroup')<CR>",
			desc = "Focus below window",
		},
		{
			"<leader>k",
			"<cmd>call VSCodeNotify('workbench.action.focusAboveGroup')<CR>",
			desc = "Focus above window",
		},
		{
			"<leader>l",
			"<cmd>call VSCodeNotify('workbench.action.focusRightGroup')<CR>",
			desc = "Focus right window",
		},

		{
			"<C-c>",
			"<cmd>call VSCodeNotify('editor.action.clipboardCopyAction')<CR>",
			mode = "x",
			desc = "Copy selection",
		},
		{
			"<C-c>",
			"<cmd>call VSCodeNotify('editor.action.clipboardCopyAction')<CR>",
			mode = { "n", "i" },
			desc = "Copy line",
		},
	},
})
