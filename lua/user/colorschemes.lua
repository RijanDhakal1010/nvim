local colorscheme = "catppuccin" -- This is where the colorsheme is specified.

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme) -- .. is string concatanation in lua, so vim.cmd, "colorscheme " .. colorscheme is vim.cmd, "colorscheme " .. {local colorscheme}
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end
