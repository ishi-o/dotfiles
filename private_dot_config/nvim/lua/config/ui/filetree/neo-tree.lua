local opts = {
	sources = { "filesystem", "buffers", "git_status" },
	open_files_do_not_replace_types = { "terminal", "qf", "Outline" },
	filesystem = {
		group_empty_dirs = true,
		bind_to_cwd = false,
		filtered_items = {
			visible = true,
			hide_dotfiles = false,
			hide_gitignored = false,
		},
		follow_current_file = {
			enabled = true,
		},
		use_libuv_file_watcher = true,
		renderer = {
			icons = {
				enable = true,
			},
		},
	},
	window = {
		width = math.floor(vim.o.columns * 0.3),
		mappings = {
			["l"] = "open",
			["h"] = "close_node",
			["<space>"] = "none",
			["Y"] = {
				function(state)
					local node = state.tree:get_node()
					vim.fn.setreg("+", node:get_id(), "c")
				end,
				desc = "Copy Path to Clipboard",
			},
			["O"] = {
				function(state)
					require("lazy.util").open(state.tree:get_node().path, { system = true })
				end,
				desc = "Open with System Application",
			},
			["P"] = { "toggle_preview", config = { use_float = false } },
		},
	},
	default_component_configs = {
		indent = {
			with_expanders = true,
			expander_collapsed = "",
			expander_expanded = "",
			expander_highlight = "NeoTreeExpander",
		},
		git_status = {
			symbols = {
				unstaged = "󰄱",
				staged = "󰱒",
			},
		},
	},
}
local function on_move(data)
	Snacks.rename.on_rename_file(data.source, data.destination)
end
local events = require("neo-tree.events")
opts.event_handlers = opts.event_handlers or {}
vim.list_extend(opts.event_handlers, {
	{ event = events.FILE_MOVED,   handler = on_move },
	{ event = events.FILE_RENAMED, handler = on_move },
})
require("neo-tree").setup(opts)
