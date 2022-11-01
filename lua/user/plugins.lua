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

  use "sainnhe/everforest" -- The color schemes plugin

  -- This chunk of code automatically sets up the configuration after cloning packer.nvim
  -- It should go after the list of plugins to be installed
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
