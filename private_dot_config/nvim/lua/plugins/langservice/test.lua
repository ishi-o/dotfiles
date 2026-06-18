return {
	"nvim-neotest/neotest",
	enabled = false,
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-treesitter/nvim-treesitter",
		"folke/trouble.nvim",
		"nvim-lua/plenary.nvim",
		"nvim-neotest/neotest-python",
		{
			"fredrikaverpil/neotest-golang",
			version = "*",
			build = function()
				vim.system({ "go", "install", "gotest.tools/gotestsum@latest" }):wait()
			end,
		},
		{
			"rcasia/neotest-java",
			build = ":NeotestJava setup",
		},
		config = function()
			local neotest_ns = vim.api.nvim_create_namespace("neotest")
			vim.diagnostic.config({
				virtual_text = {
					format = function(diagnostic)
						local message =
							diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
						return message
					end,
				},
			}, neotest_ns)
			local config = {
				diagnostic = {
					enabled = true,
				},
				adapters = {
					require("neotest-python")({
						dap = { justMyCode = false },
					}),
					require("neotest-golang")({
						runner = "gotestsum",
						dap_go_enabled = true,
						testify_enabled = true,
					}),
					require("neotest-java")({}),
				},
				status = { virtual_text = true },
				output = { open_on_run = true },
				quickfix = {
					open = function()
						require("trouble").open({ mode = "quickfix", focus = false })
					end,
				},
				consumers = {
					trouble = function(client)
						client.listeners.results = function(adapter_id, results, partial)
							if partial then
								return
							end
							local tree = assert(client:get_position(nil, { adapter = adapter_id }))
							local failed = 0
							for pos_id, result in pairs(results) do
								if result.status == "failed" and tree:get_key(pos_id) then
									failed = failed + 1
								end
							end
							vim.schedule(function()
								local trouble = require("trouble")
								if trouble.is_open() then
									trouble.refresh()
									if failed == 0 then
										trouble.close()
									end
								end
							end)
							return {}
						end
					end,
				},
			}
			require("neotest").setup(config)
		end,
	},
}
