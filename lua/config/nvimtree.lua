local gwidth = vim.api.nvim_list_uis()[1].width
local gheight = vim.api.nvim_list_uis()[1].height
local width = 60
local height = 20

local M = {}

function M.setup()
  require("nvim-tree").setup {
    disable_netrw = true,
    hijack_netrw = true,
    view = {
      number = true,
      relativenumber = true,
	  width = width,
	  float = {
		enable = true,
		open_win_config = {
			relative = "editor",
        	width = width,
        	height = height,
        	row = (gheight - height) * 0.4,
        	col = (gwidth - width) * 0.5,
		}
	  }
    },
    filters = {
      custom = { ".git" },
    },
  }
end

return M  
