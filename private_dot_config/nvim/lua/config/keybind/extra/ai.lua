return {
	{
		cond = function()
			return _G.plugin_installed("claudecode.nvim")
		end,
		{ "<leader>aa", "<cmd>ClaudeCode<CR>", desc = "Toggle Claude Code" },
		{ "<leader>as", "<cmd>ClaudeCodeSend<CR>", desc = "Send to Claude Code", mode = { "n", "x" } },
		{ "<leader>ad", "<cmd>ClaudeCodeDiffAccept<CR>", desc = "Accept Diff" },
		{ "<leader>ar", "<cmd>ClaudeCodeDiffReject<CR>", desc = "Reject Diff" },
		{ "]d", "<cmd>ClaudeCodeDiffNext<CR>", desc = "Next Diff" },
		{ "[d", "<cmd>ClaudeCodeDiffPrev<CR>", desc = "Previous Diff" },
		{ "<leader>ac", "<cmd>ClaudeCodeChatNew<CR>", desc = "New Chat" },
		{ "<leader>ah", "<cmd>ClaudeCodeChatHistory<CR>", desc = "Chat History" },
		{ "<leader>aC", "<cmd>ClaudeCodeChatClear<CR>", desc = "Clear Chat" },
		{ "<leader>af", "<cmd>ClaudeCodeFileAdd<CR>", desc = "Add File to Context" },
		{ "<leader>aF", "<cmd>ClaudeCodeFileAddAll<CR>", desc = "Add All Files to Context" },
		{ "<leader>am", "<cmd>ClaudeCodeModelSelect<CR>", desc = "Select Model" },
		{ "<leader>ap", "<cmd>ClaudeCodeModePlan<CR>", desc = "Plan Mode" },
		{ "<leader>ab", "<cmd>ClaudeCodeModeBuild<CR>", desc = "Build Mode" },
		{ "<leader>aA", "<cmd>ClaudeCodeModeAuto<CR>", desc = "Auto Mode" },
	},
	{
		cond = function()
			return _G.plugin_installed("codecompanion.nvim")
		end,
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
	},
	{
		cond = function()
			return _G.plugin_installed("avante.nvim")
		end,
		{ "<leader>aa", "<cmd>AvanteAsk<CR>", desc = "Ask Avante" },
		{ "<leader>ac", "<cmd>AvanteChat<CR>", desc = "Chat with Avante" },
		{ "<leader>ae", "<cmd>AvanteEdit<CR>", desc = "Edit Avante" },
		{ "<leader>af", "<cmd>AvanteFocus<CR>", desc = "Focus Avante" },
		{ "<leader>ah", "<cmd>AvanteHistory<CR>", desc = "Avante History" },
		{ "<leader>am", "<cmd>AvanteModels<CR>", desc = "Select Avante Model" },
		{ "<leader>an", "<cmd>AvanteChatNew<CR>", desc = "New Avante Chat" },
		{ "<leader>ap", "<cmd>AvanteSwitchProvider<CR>", desc = "Switch Avante Provider" },
		{ "<leader>ar", "<cmd>AvanteRefresh<CR>", desc = "Refresh Avante" },
		{ "<leader>as", "<cmd>AvanteStop<CR>", desc = "Stop Avante" },
		{ "<leader>at", "<cmd>AvanteToggle<CR>", desc = "Toggle: Avante" },
	},
	{
		cond = function()
			return _G.plugin_installed("copilot.lua")
		end,
		{ "<leader>aC", "<cmd>Copilot toggle<CR>", desc = "Toggle: Copilot connection" },
	},
}
