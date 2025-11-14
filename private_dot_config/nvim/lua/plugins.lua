vim.cmd [[packadd packer.nvim]]
return require("packer").startup(function(use)
	-- packer itself
    use "wbthomason/packer.nvim"

	-- lsp core
	use {
		"neovim/nvim-lspconfig",

		config = function()
			require("config.lsp").setup()
		end
	}

	-- complete
	use {
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",

		config = function()
		-- require("config.cmp").setup()
		end
	}

    -- colortheme
    use {
        "folke/tokyonight.nvim",
		"sainnhe/everforest",

		config = function()
			require("config.colortheme").setup()
		end
    }

	-- -- nvim-tree
	-- use {
	-- 	"nvim-tree/nvim-tree.lua",
	-- 	requires = {
	-- 		"nvim-tree/nvim-web-devicons"
	-- 	},
	-- }
    
	-- comment
	use {
	  "numToStr/Comment.nvim",

	  config = function()
		  require("config.Comment").setup()
	  end
	}

	-- inner-terminal
	use {
		"akinsho/toggleterm.nvim",

		config = function()
			require("config.toggleterm").setup()
		end
	}

	-- neo-tree
	use {
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		requires = { 
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},

		config = function()
			require("config.neo-tree").setup()
		end
	}

end)
