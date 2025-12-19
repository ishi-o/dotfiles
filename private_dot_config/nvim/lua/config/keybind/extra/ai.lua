-- ai --
return {
	-- CodeCompanion --
	{ "<leader>fa", "<cmd>CodeCompanionActions<CR>", desc = "Ai actions" },
	{ "<leader>an", "<cmd>CodeCompanionChat<CR>", desc = "New chat" },
	{
		"<leader>aa",
		function()
			vim.api.nvim_feedkeys(":", "n", false)
			vim.defer_fn(function()
				vim.api.nvim_feedkeys("CodeCompanion ", "n", false)
			end, 50)
		end,
		desc = "Ask",
		mode = { "n", "x" },
	},

	-- Avante --
	-- { "<leader>aa", "<cmd>AvanteAsk<CR>", desc = "Ask Avante" },
	-- { "<leader>ac", "<cmd>AvanteChat<CR>", desc = "Chat with Avante" },
	-- { "<leader>ae", "<cmd>AvanteEdit<CR>", desc = "Edit Avante" },
	-- { "<leader>af", "<cmd>AvanteFocus<CR>", desc = "Focus Avante" },
	-- { "<leader>ah", "<cmd>AvanteHistory<CR>", desc = "Avante History" },
	-- { "<leader>am", "<cmd>AvanteModels<CR>", desc = "Select Avante Model" },
	-- { "<leader>an", "<cmd>AvanteChatNew<CR>", desc = "New Avante Chat" },
	-- { "<leader>ap", "<cmd>AvanteSwitchProvider<CR>", desc = "Switch Avante Provider" },
	-- { "<leader>ar", "<cmd>AvanteRefresh<CR>", desc = "Refresh Avante" },
	-- { "<leader>as", "<cmd>AvanteStop<CR>", desc = "Stop Avante" },
	-- { "<leader>at", "<cmd>AvanteToggle<CR>", desc = "Toggle: Avante" },

	-- Copilot --
	-- {
	-- 	"<leader>aC",
	-- 	"<cmd>Copilot toggle<CR>",
	-- 	desc = "Toggle: Copilot connection",
	-- },
}
