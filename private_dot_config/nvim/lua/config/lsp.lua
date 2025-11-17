local on_attach = function(client, bufnr)
	local opts = { buffer = bufnr, noremap = true, silent = true }

	vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
	vim.keymap.set("n", "<Leader>rn", vim.lsp.buf.rename, opts)
	vim.keymap.set("n", "<Leader>ca", vim.lsp.buf.code_action, opts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

	if client.name == "jdtls" then
		vim.keymap.set("n", "<F5>", function()
			-- local file_path = vim.fn.expand("%:p")
			local dir_path = vim.fn.expand("%:p:h")
			local root_files = vim.fs.find("pom.xml", { upward = true, path = dir_path })
			local project_root = root_files[1] and vim.fn.fnamemodify(root_files[1], ":h") or dir_path

			require("telescope.builtin").live_grep({
				cwd = project_root,
				prompt_title = "Select a Main Class to Run",
				default_text = "public static void main",
				search_dirs = { project_root .. "/src/main/java" },
				attach_mappings = function(prompt_bufnr, map)
					local actions = require("telescope.actions")
					local action_state = require("telescope.actions.state")
					local function run_java()
						local selection = action_state.get_selected_entry()
						actions.close(prompt_bufnr)

						if selection then
							local full_file_path = selection.filename

							local file = io.open(full_file_path, "r")
							local package_name = ""
							local class_name = vim.fn.fnamemodify(full_file_path, ":t:r")

							if file then
								for line in file:lines() do
									local package_match = line:match("^%s*package%s+(.+);")
									if package_match then
										package_name = package_match
										break
									end
								end
								file:close()
							end

							local full_class_name
							if package_name ~= "" then
								full_class_name = package_name .. "." .. class_name
							else
								local src_main_java = project_root .. "/src/main/java/"
								if vim.startswith(full_file_path, src_main_java) then
									full_class_name = string.sub(full_file_path, #src_main_java + 1, -6):gsub("/", ".")
								else
									full_class_name = class_name
								end
							end

							local command = "cd '"
								.. project_root
								.. "' && mvn compile exec:java -Dexec.mainClass=\""
								.. full_class_name
								.. '" -q'
							local Terminal = require("toggleterm.terminal").Terminal
							local mvn_term = Terminal:new({
								cmd = command,
								close_on_exit = false,
							})
							mvn_term:toggle()
						end
					end

					vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
					map("n", "<CR>", run_java)
					return true
				end,
			})
		end, { buffer = bufnr, desc = "Run Java File" })

		vim.keymap.set("n", "<F7>", function()
			require("dap").run({
				type = "java",
				request = "launch",
				name = "Debug Current File",
				program = vim.fn.expand("%:p"),
				console = "integratedTerminal",
			})
		end, { buffer = bufnr, desc = "Debug Java File" })
	end
end

require("mason").setup({})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "java",
	callback = function()
		-- check jdtls
		local mason_registry = require("mason-registry")
		if not mason_registry.is_installed("jdtls") then
			mason_registry.get_package("jdtls"):install()
		end

		local root_files = vim.fs.find({ ".git", "mvnw", "gradlew", "pom.xml" }, { upward = true })
		local root_dir = vim.fs.dirname(root_files[1])
		local config = {
			name = "jdtls",
			cmd = { "jdtls" },
			root_dir = root_dir,
			on_attach = on_attach,
			settings = {
				java = {
					signatureHelp = { enabled = true },
				},
			},
			init_options = {
				bundles = {
					vim.fn.glob(
						vim.fn.stdpath("data")
							.. "/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar",
						1,
						1
					)[1],
				},
			},
		}
		vim.lsp.start(config)
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "lua",
	callback = function()
		local mason_registry = require("mason-registry")
		if not mason_registry.is_installed("lua-language-server") then
			mason_registry.get_package("lua-language-server"):install():once(
				"closed",
				vim.schedule_wrap(function()
					if mason_registry.is_installed("lua-language-server") then
						vim.cmd("edit")
					end
				end)
			)
			return
		end

		local root_files = {
			".git",
			".luarc.json",
			".luacheckrc",
			"stylua.toml",
			".editorconfig",
		}

		local root_markers = vim.fs.find(root_files, { upward = true })
		local root_dir = root_markers[1] and vim.fs.dirname(root_markers[1]) or vim.loop.cwd()

		local config = {
			name = "lua_ls",
			cmd = { "lua-language-server" },
			root_dir = root_dir,
			on_attach = on_attach,
			settings = {
				Lua = {
					runtime = {
						version = "LuaJIT",
					},
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						library = {
							[vim.fn.expand("$VIMRUNTIME/lua")] = true,
							[vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
						},
						checkThirdParty = false,
					},
					telemetry = {
						enable = false,
					},
				},
			},
		}

		vim.lsp.start(config)
	end,
})
