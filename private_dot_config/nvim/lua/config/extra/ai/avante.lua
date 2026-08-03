local general_provider_config = {
	__inherited_from = "openai",
	timeout = 10000,
}

---@param provider_config AvanteSupportedProvider
---@param local_config? AvanteSupportedProvider
---@return AvanteSupportedProvider
local function extend_provider_config(provider_config, local_config)
	return vim.tbl_deep_extend("force", provider_config, local_config or general_provider_config)
end

--- @type AvanteSupportedProvider
local deepseek_provider = {
	model = "deepseek-chat",
	api_key_name = "AVANTE_DEEPSEEK_API_KEY",
	endpoint = "https://api.deepseek.com",
	extra_request_body = {
		temperature = 0,
	},
}

--- @type AvanteSupportedProvider
local openai_provider = {
	model = "gpt-4.1",
	api_key_name = "AVANTE_OPENAI_API_KEY",
	endpoint = "https://api.openai.com/v1",
	extra_request_body = {
		max_tokens = 20480,
		temperature = 0,
	},
}

--- @type AvanteSupportedProvider
local xfyun_provider = {
	model = "astron-code-latest",
	api_key_name = "AVANTE_XFYUN_API_KEY",
	endpoint = "https://maas-coding-api.cn-huabei-1.xf-yun.com/v2",
	extra_request_body = {
		temperature = 0,
	},
}

local ok, avante = pcall(require, "avante")
if ok then
	avante.setup({
		-- mode = "legacy",
		mode = "agentic",
		provider = "xfyun",
		providers = {
			--- @type AvanteSupportedProvider
			deepseek = extend_provider_config(deepseek_provider),
			openai = extend_provider_config(openai_provider),
			xfyun = extend_provider_config(xfyun_provider),
		},
		rag_service = {
			enabled = true,
			llm = extend_provider_config(xfyun_provider, {
				api_key = "AVANTE_XFYUN_API_KEY",
				extra = nil,
			}),
			embed = extend_provider_config(xfyun_provider, {
				api_key = "AVANTE_XFYUN_API_KEY",
				extra = nil,
			}),
		},
		behaviour = {
			enable_inline_suggestions = true,
			auto_set_keymaps = false,
			auto_approve_tool_permissions = false,
			auto_add_current_file = false,
			-- auto_suggestions = true,
		},
		selection = {
			hint_display = "none",
		},
		disabled_tools = {
			"list_files",
			"search_files",
			"read_file",
			"create_file",
			"rename_file",
			"delete_file",
			"create_dir",
			"rename_dir",
			"delete_dir",
			"bash",
		},
		system_prompt = function()
			local ok2, mcphub = pcall(require, "mcphub")
			if ok2 then
				local hub = mcphub.get_hub_instance()
				return hub and hub:get_active_servers_prompt() or ""
			end
			return ""
		end,
		custom_tools = function()
			local ok3, mcphub_ext = pcall(require, "mcphub.extensions.avante")
			if ok3 then
				return { mcphub_ext.mcp_tool() }
			end
			return {}
		end,
		input = {
			provider = "snacks",
			provider_opts = {
				title = "Avante Input",
				icon = " ",
			},
		},
		windows = {
			width = 45,
		},
	})
end
