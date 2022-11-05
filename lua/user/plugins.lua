local fn = vim.fn

-- This chunk of code is supposed to install packer if it is not already there.
-- I do not currently understand Lua good enough for it to make sense to me.
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- This chuck of code is supposed to reload neovim whenever the plugins.lua file is changed/saved
-- I do not currently understand lua good enough for it to make sense to me.
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- This chunk of code is suppoed to make a protected call so that neovim does not error out on first use
-- I do not understand lua good enough for it to make sense to me.
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Configure packer to use a pop-up window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- This is where plugins are installed
return packer.startup(function(use)
  -- The list of plugins here
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins

  -- Extra plugins

  -- The one in use for colorscheme

  use {
	  "catppuccin/nvim",
	  as = "catppuccin",
	  config = function()
		  require("catppuccin").setup {
			  flavour = "macchiato" -- mocha, macchiato, frappe, latte
		  }
		  vim.api.nvim_command "colorscheme catppuccin"
	  end
  }

-- The ones for cmp

  use "hrsh7th/nvim-cmp"
  use "hrsh7th/cmp-buffer"
  use "hrsh7th/cmp-path"
  use "hrsh7th/cmp-cmdline"
  use "saadparwaiz1/cmp_luasnip"

-- These are the ones for snippets

  use "L3MON4D3/LuaSnip"
  use "rafamadriz/friendly-snippets"

-- plugins for auto-completion

  use "neovim/nvim-lspconfig" -- enable LSP.
  use "williamboman/mason.nvim" -- simple to use language server installer.
  use "williamboman/mason-lspconfig.nvim" -- simple to use language server installer

-- This is the plugin that helps with markdown.
  use({
  "iamcco/markdown-preview.nvim",
  run = function() vim.fn["mkdp#util#install"]() end,}) -- This is the plugin to use markdown preview. This specific config is designed to be used without npm (which is how I prefer it).

  -- This chunk of code automatically sets up the configuration after cloning packer.nvim
  -- It should go after the list of plugins to be installed
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
