local renderer = require("neo-tree.ui.renderer")

local opts = {
	sources = { "filesystem", "buffers", "git_status" },
	open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
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
			["J"] = {
				function(state)
					vim.cmd("normal! m'")
					local node = state.tree:get_node()
					local parent_id = node:get_parent_id()
					if not parent_id then
						vim.cmd("normal! j")
						return
					end
					local parent = state.tree:get_node(parent_id)
					local grandparent_id = parent:get_parent_id()
					if not grandparent_id then
						vim.cmd("normal! j")
						return
					end
					local grandparent = state.tree:get_node(grandparent_id)
					local uncles = grandparent:get_child_ids()
					local parent_idx = 0
					for i, uncle_id in ipairs(uncles) do
						if uncle_id == parent_id then
							parent_idx = i
							break
						end
					end
					if parent_idx < #uncles then
						renderer.focus_node(state, uncles[parent_idx + 1])
					else
						vim.cmd("normal! j")
					end
				end,
				desc = "Parent's next brother",
			},
			["K"] = {
				function(state)
					vim.cmd("normal! m'")
					local node = state.tree:get_node()
					local parent_id = node:get_parent_id()
					if not parent_id then
						vim.cmd("normal! k")
						return
					end
					local parent = state.tree:get_node(parent_id)
					if not parent:get_parent_id() then
						vim.cmd("normal! k")
						return
					end
					renderer.focus_node(state, parent_id)
				end,
				desc = "Parent",
			},
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
	{ event = events.FILE_MOVED, handler = on_move },
	{ event = events.FILE_RENAMED, handler = on_move },
})
require("neo-tree").setup(opts)
