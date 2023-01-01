local M = {}

function M.setup()
  -- Indicate first time installation
  local packer_bootstrap = false

  local conf = {
    profile = {
      enable = true,
      threshold =0, -- this tracks the loading time of a plugin beyond the noted threshold
    },
    display = {
      open_fn = function()
        return require("packer.util").float { border = "rounded" }
      end,
    },
  }

  -- Check if packer.nvim is installed
  -- Run PackerCompile if there are changes in this fi
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

    use {"wbthomason/packer.nvim"}

		-- The section to hopefully manage the lsp-config which has been so far quite elusive.
		--[[ For now this will have to be do in a]]
    -- install tree-sitter here
		use {"nvim-treesitter/nvim-treesitter"}
		-- seems I will need telescope as well for all of this to work #TODO
		use {
			"nvim-telescope/telescope.nvim",
			requires = {
				"nvim-lua/plenary.nvim"
			}
		}

		use {
      "hrsh7th/nvim-cmp",
			config = function()
				require("config.cmp").setup()
			end,
      requires = {
        "hrsh7th/cmp-nvim-lsp",
		    "hrsh7th/cmp-buffer",
		    "hrsh7th/cmp-path",
		    "hrsh7th/cmp-cmdline",
		    "L3MON4D3/LuaSnip",
		    "saadparwaiz1/cmp_luasnip",
      }
		}

		use{
			"neovim/nvim-lspconfig",
			config = function()
				require("config.lsp_keymaps")
			end,
			requires = {
				{
          "williamboman/mason.nvim",
          config = function()
            require('mason').setup()
          end,
        },
				{
          "williamboman/mason-lspconfig.nvim",
          config = function()
            require("config.mason_lspconfig").setup()
          end,
        },
        {
          "j-hui/fidget.nvim",
          config = function()
            require("fidget").setup()
          end,
        },
			},
		}

    -- the fzf plugin
    use{
      "ibhagwan/fzf-lua",
      requires = {"kyazdani42/nvim-web-devicons"},
		}
    -- This is the buffer line plugin

    use{
      "akinsho/nvim-bufferline.lua",
      event = "BufReadPre",
      wants = "nvim-web-devicons",
      config = function()
        require("config.bufferline").setup()
      end,
    }

    -- colorschemes
		use {"EdenEast/nightfox.nvim"}

		-- Startup screen
    use{
      "goolord/alpha-nvim",
      config = function()
        require("config.alpha").setup()
      end,
    }

    -- The plugin for the status line

    use {
      'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true },
        config= function()
          require('lualine').setup()
          options = { theme = 'gruvbox' }
        end
    }

		-- The plugin for the blank-lines
		use {
			"lukas-reineke/indent-blankline.nvim",
			config = function()
				require("config.blankline").setup()
			end,
		}

    -- The config for Nvimtree

    use {
      "kyazdani42/nvim-tree.lua",
      requires = {
        "kyazdani42/nvim-web-devicons",
      },
      cmd = {"NvimTreeToggle", "NvimTreeClose"},
      config = function()
        require("config.nvimtree").setup()
      end,
    }

    -- Markdwon preview

    use ({
      "iamcco/markdown-preview.nvim",
      run = function() vim.fn["mkdp#util#install"]() end,
    })

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
