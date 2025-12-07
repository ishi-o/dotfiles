vim.api.nvim_create_autocmd("FileType", {
	pattern = "java",
	callback = function(args)
		local conf = require("config.dev.lsp.conf")

		local mason_dir = vim.fn.stdpath("data") .. "/mason"
		local share_dir = mason_dir .. "/share"
		local lombok_path = share_dir .. "/jdtls/lombok.jar"
		local root_dir = vim.fs.root(0, { "gradlew", "mvnw", "pom.xml", ".git" })

		local bundles = {
			vim.fn.glob(share_dir .. "/java-debug-adapter/com.microsoft.java.debug.plugin-*.jar", 1),
			lombok_path,
		}
		local function add_bundles(path, bs)
			local jar_files = vim.split(path, "\n")
			for _, jar_file in ipairs(jar_files) do
				table.insert(bs, jar_file)
			end
		end
		add_bundles(vim.fn.glob(share_dir .. "/vscode-spring-boot-tools/jdtls/*.jar"), bundles)
		add_bundles(vim.fn.glob(vim.fn.glob(share_dir .. "/vscode-java-decompiler/bundles/*.jar")), bundles)

		local function custom_definition()
			local clients = vim.lsp.get_clients({ name = "jdtls", bufnr = vim.api.nvim_get_current_buf() })
			if #clients == 0 then
				return
			end
			local client = clients[1]
			local params = vim.lsp.util.make_position_params()
			local symbol_result = vim.lsp.buf_request_sync(0, "textDocument/definition", params, 1000)

			if not symbol_result or vim.tbl_isempty(symbol_result) then
				return
			end

			local first_result = symbol_result[client.id]
			if not first_result or not first_result.result or #first_result.result == 0 then
				vim.lsp.buf.definition()
				return
			end

			local location = first_result.result[1]
			local uri = location.uri or location.targetUri
			local target_range = location.range or location.targetRange
			if uri and uri:match("%.class$") then
				local original_win = vim.api.nvim_get_current_win()
				local original_buf = vim.api.nvim_get_current_buf()
				local original_cursor = vim.api.nvim_win_get_cursor(original_win)
				client.request("workspace/executeCommand", {
					command = "java.decompile",
					arguments = { uri },
				}, function(decompile_err, decompile_result)
					if decompile_err or not decompile_result then
						vim.notify("反编译失败: " .. (decompile_err or "未知错误"), vim.log.levels.ERROR)
						vim.lsp.buf.definition()
						return
					end
					local temp_buf = vim.api.nvim_create_buf(true, false) -- 未命名缓冲区
					local lines = vim.split(decompile_result, "\n")
					vim.api.nvim_buf_set_lines(temp_buf, 0, -1, false, lines)
					vim.api.nvim_set_option_value("filetype", "java", { buf = temp_buf })
					vim.api.nvim_set_option_value("buftype", "nofile", { buf = temp_buf })
					vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = temp_buf })
					vim.api.nvim_set_option_value("swapfile", false, { buf = temp_buf })
					local class_name = vim.fn.fnamemodify(uri, ":t:r")
					vim.api.nvim_buf_set_name(temp_buf, "Decompiled://" .. class_name)
					vim.api.nvim_win_set_buf(original_win, temp_buf)
					if target_range then
						local target_line = target_range.start.line + 1 -- LSP行号从0开始
						local target_col = target_range.start.character
						if target_line <= #lines then
							vim.api.nvim_win_set_cursor(original_win, { target_line, target_col })
							vim.cmd("normal! zz") -- 居中显示
						else
							vim.api.nvim_win_set_cursor(original_win, { 1, 0 })
						end
					end
					vim.keymap.set("n", "<Esc>", function()
						if vim.api.nvim_win_is_valid(original_win) then
							vim.api.nvim_win_set_buf(original_win, original_buf)
							vim.api.nvim_win_set_cursor(original_win, original_cursor)
						end
					end, { buffer = temp_buf, silent = true })

					vim.keymap.set("n", "q", function()
						if vim.api.nvim_win_is_valid(original_win) then
							vim.api.nvim_win_set_buf(original_win, original_buf)
							vim.api.nvim_win_set_cursor(original_win, original_cursor)
						end
					end, { buffer = temp_buf, silent = true })
				end, vim.api.nvim_get_current_buf())
			else
				vim.lsp.buf.definition()
			end
		end

		vim.lsp.config("jdtls", {
			cmd = {
				"jdtls",
				string.format("--jvm-arg=-javaagent:%s", lombok_path),
				"-configuration",
				vim.fn.stdpath("cache") .. "/jdtls/" .. root_dir .. "/config",
				"-data",
				vim.fn.stdpath("cache") .. "/jdtls/" .. root_dir .. "/workspace",
			},
			root_dir = root_dir,
			init_options = {
				bundles = bundles,
				extendedClientCapabilities = {
					classFileContentsSupport = true,
					decompilationSupport = true,
				},
			},
			on_attach = function(client, bufnr)
				conf.on_attach(client, bufnr)
				client.server_capabilities.textDocumentSync = vim.lsp.protocol.TextDocumentSyncKind.Incremental
				vim.keymap.set("n", "gj", custom_definition)
			end,
			capabilities = conf.capabilities,
			filetypes = { "java", "jproperties", "yaml" },
		})
	end,
})
