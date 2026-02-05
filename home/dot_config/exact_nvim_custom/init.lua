if vim.fn.has('nvim-0.11') ~= 1 then
  vim.notify('Minimum supported neovim version is v0.11. Try updating Neovim.\n', vim.log.levels.ERROR)
  return
end

-- Define config table to be able to pass data between scripts
_G.Custom = {}
_G.Custom.helpers = require("helpers")
_G.Custom.config = require("config")
_G.Custom.metadata = require("metadata")

require("core")
if not vim.g.vscode then
  require("plugins")
end
