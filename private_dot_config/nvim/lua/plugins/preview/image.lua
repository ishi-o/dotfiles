return {
	-- image.nvim --
	-- image support
	-- 图像预览支持 (要求终端遵循 kitty 协议, 系统包含 ImageMagick)
	{
		"3rd/image.nvim",
		lazy = true,
		ft = "image",
		config = function()
			require("config.preview.image")
		end,
	},
}
