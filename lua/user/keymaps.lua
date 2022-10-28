local opts = {noremap = true, silent = true} -- This does two things: 1. It sets opts as { noremap = true, silent = true } 2. norempa makes the mapping non-recursive and silent makes the mapping silent. Here (https://vi.stackexchange.com/questions/2089/what-are-the-differences-between-the-map-noremap-abbrev-and-noreabbrev-command) is some good reading on why non-recursive mapping should be preferred.

local term_opts = { silent = true } -- This does two things: 1. It sets term_opts = { silent = true } 2.  Silent makes the mapping silent.

-- Shorten function name
local keymap = vim.api.nvim_set_keymap -- This just sets keymap = vim.api.nvim_set_keymap and saves us the trouble of having to type everything again and again.

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts) -- This maps the leader key to the space bar.
vim.g.mapleader = " " -- not sure what this does
vim.g.maplocalleader = " " -- not sure what this does

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal mode -- 
-- Window navigation --

keymap("n", "<leader>e", ":Lex 30<cr>", opts) -- This maps :Lexplore 30 (enter) to space bar + e

-- Insert mode --
keymap("i", "<C-s>", "<Esc>:w<cr>", opts) -- This maps the 'crtl + s ' combintaion to save the file in its current state.
