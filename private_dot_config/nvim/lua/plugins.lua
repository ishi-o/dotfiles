vim.cmd [[packadd packer.nvim]]
return require("packer").startup(function(use)
    use "wbthomason/packer.nvim"
    -- colortheme
    use {
        "folke/tokyonight.nvim",
		"sainnhe/everforest"
    }
end)
