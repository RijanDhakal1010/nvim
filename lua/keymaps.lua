local keymap = vim.api.nvim_set_keymap -- Refrences the whole command to keymap for ease of use
local default_opts = { noremap = true, silent = true } -- Do not want recursion on
local expr_opts = { noremap = true, expr = true, silent = true } -- Expr = true sets expression to be true as: keymap("n", "<leader>e", ":Lex 30 * 2<cr>", expr_opts), `:Lex 60<cr>`

--Remap space as leader key
keymap("", "<Space>", "<Nop>", default_opts) -- This maps the leader key to the space bar.
vim.g.mapleader = " " -- set space to leader
vim.g.maplocalleader = " " -- set space to leader

keymap("n", "<leader>e", ":NvimTreeToggle<cr>", default_opts)  -- This maps :Lexplore 30 (enter) to space bar + e

-- Insert mode --
keymap("i", "<C-s>", "<Esc>:w<cr>", default_opts) -- This maps the 'crtl + s ' combintaion to save the file in its current state.

-- Map crtl + backspace to delete the previous word
keymap("i", '<C-H>', '<C-W>', default_opts)
