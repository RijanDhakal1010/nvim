local M = {}

function M.setup()
  -- Indicate first time installation
  local packer_bootstrap = false

  -- packer.nvim configuration
  local conf = {
	  profile = {enable = true,
  threhold = 0, -- this tracks the loading time of a plugin beyond the noted threshold
  },
    display = {
      open_fn = function()
        return require("packer.util").float { border = "rounded" }
      end,
    },
  }

  -- Check if packer.nvim is installed
  -- Run PackerCompile if there are changes in this file
  local function packer_init()
    local fn = vim.fn
    local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then -- Empty checks if the designated folder is empty. False = 0 and True = 1. 
      local success, result = pcall(function()
        packer_bootstrap = fn.system {
          "git",
          "clone",
          "--depth",
          "1",
          "https://github.com/wbthomason/packer.nvim",
          install_path,
        }
        vim.cmd [[packadd packer.nvim]]
      end)
      if not success then
        -- Hanlde the error here
        print("An error occurred while installing packer.nvim using the bootstrap function: " .. tostring(result))
      end
    end
    vim.cmd "autocmd BufWritePost plugins.lua source <afile> | PackerCompile"
  end

  -- This bit of code makes the plugin.lua file source itself everytime it is changed or saved.
  vim.cmd [[
	augroup packer_user_config
		autocmd!
		autocmd BufWritePost plugins.lua source <afile> | PackerSync
	augroup end
  ]]

  -- Sample plugin installation

  --use{
  --  "", -- plugin location
  --  as = "catppuccin", -- define as 
  --  config= function() -- config
	--    require("<as>").setup{
	--		-- place commands here
	--    }
	--    vim.api.nvim_command "" -- any vim specific commands here
  --  end
  --  }

  -- Plugins
  local function plugins(use)
    use { "wbthomason/packer.nvim" }

	-- the fzf plugin
	
	use {
		"ibhagwan/fzf-lua",
		requires = {"kyazdani42/nvim-web-devicons"},
	}

    -- Colorscheme
    use{
    "catppuccin/nvim",
    as = "catppuccin",
    config= function()
		require("catppuccin").setup{
			flavour = "macchiato"
		}
		vim.api.nvim_command "colorscheme catppuccin"
    end
    }
	

	-- This is the buffer line plugin
	use {
    "akinsho/nvim-bufferline.lua",
    event = "BufReadPre",
    wants = "nvim-web-devicons",
    config = function()
      require("config.bufferline").setup()
    end,
  }

    -- Startup screen
    use {
      "goolord/alpha-nvim",
      config = function()
        require("config.alpha").setup()
      end,
    }
	-- The plugin for the status line
    use{
		'nvim-lualine/lualine.nvim',
		requires = { 'kyazdani42/nvim-web-devicons', opt = true },
      config= function()
        require('lualine').setup()
        options = { theme = 'gruvbox' }
      end
    }
	
	-- The config for Nvimtree
	
	use{
 "kyazdani42/nvim-tree.lua",
 requires = {
   "kyazdani42/nvim-web-devicons",
 },
 cmd = { "NvimTreeToggle", "NvimTreeClose" },
   config = function()
     require("config.nvimtree").setup()
   end,
}
	-- Markdown preview
	use({
	"iamcco/markdown-preview.nvim",
	run = function() vim.fn["mkdp#util#install"]() end,
})

    -- Git
    --use {
    --  "TimUntersberger/neogit",
    --  requires = "nvim-lua/plenary.nvim",
    --  config = function()
    --    require("config.neogit").setup()
    --  end,
    --}

    if packer_bootstrap then
      print "Restart Neovim required after installation!"
      require("packer").sync()
    end
  end

  packer_init()

  local packer = require "packer"

  -- Use pcall to call plugins in a protected environment
  local success, result = pcall(function()
    packer.init(conf)
    packer.startup(plugins)
  end)
  
end

return M
