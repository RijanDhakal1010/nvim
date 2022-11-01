# nvim
My nvim setup.

Please note that things in this config are higly fickle. I am currently working my way through building this config up.

## On Plugin/packer_compiled.lua

This is just a file that packer.nvim makes on its own and it is okay to delete this from time to time.

## On User/plugins.lua

What is a protected call?

A protected call, within neovim within lua, is a way to initiate a task in such a way that if the task fails it reverts to an exception instead of an error that chokes execution.

This is what this bit of code is doing:
```lua
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end
```

## Where plugins live.

`.local/share/nvim` is where the plugins live.

When possible try to install plugins without npm.
