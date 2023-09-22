local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install your plugins here
return packer.startup(function(use)
	use ("wbthomason/packer.nvim") -- Have packer manage itself	

	-- Library
	use("nvim-lua/plenary.nvim")
	
	-- Startup screen
	use {
	  "startup-nvim/startup.nvim",
	  requires = {"nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim"},
	  config = function()
	    require"startup".setup()
	  end
	}

	-- Nvim Tree
	use {
	  "nvim-tree/nvim-tree.lua",
	  config = function ()
		  require"nvim-tree".setup({
			  renderer = {
				  indent_markers= {
					  enable = true,
				  },
				  icons = {
					  show = {
						  folder = true,
					  }
				  }
			  }
		  })
	  end
	}

	-- Web Dev Icons
	use("nvim-tree/nvim-web-devicons")
	
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end

	-- File Search (telescope)
	use({"nvim-telescope/telescope.nvim",
	requires = { {'nvim-lua/plenary.nvim'} },
	config=function()

	end
	})

	-- Terminal
	use({"rebelot/terminal.nvim",
		config = function ()
			local term_map = require("terminal")
			vim.keymap.set("n", "<leader>t", term_map.toggle)
			term_map.setup()
		end
	})

	-- Status Line
	use {
	  'nvim-lualine/lualine.nvim',
	  requires = { 'nvim-tree/nvim-web-devicons', opt = true },
	  config = function () 
		  require"lualine".setup()
	  end
	}
	
	-- Vim Tabs
	use 'romgrk/barbar.nvim'
    require'bufferline'.setup {sidebar_filetypes = {
      NvimTree = true,
    }}

	-- Indent Lines
	use({"lukas-reineke/indent-blankline.nvim",
	config = function ()
		require"indent_blankline".setup()
	end
}) 

	-- Auto Completion
	use{"neoclide/coc.nvim", branch = 'release'}

	-- Color scheme"
	use("EdenEast/nightfox.nvim")
	use { "catppuccin/nvim", as = "catppuccin" }
	--Better Syntax highlighting
	-- use("nvim-treesitter/nvim-treesitter")

	--Svelte Syntax Hightlight
	use("evanleck/vim-svelte")

	-- Transparent Background
	-- use 'tribela/vim-transparent'
end)
