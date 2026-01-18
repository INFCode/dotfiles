if vim.fn.has('nvim-0.11') ~= 1 then
  vim.notify('Minimum supported neovim version is v0.11. Try updating Neovim.\n', vim.log.levels.ERROR)
  return
end

-- Define config table to be able to pass data between scripts
_G.Config = {}

-- Define custom autocommand group and helper to create an autocommand.
local gr = vim.api.nvim_create_augroup('CustomConfig', { clear = true })
_G.Config.autocmd = function(event, pattern, callback, desc)
  local opts = { group = gr, pattern = pattern, callback = callback, desc = desc }
  vim.api.nvim_create_autocmd(event, opts)
end

require("core")
require("plugins")
