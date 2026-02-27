if vim.fn.has('nvim-0.11') ~= 1 then
  vim.notify('Minimum supported neovim version is v0.11. Try updating Neovim.\n', vim.log.levels.ERROR)
  return
end

-- Define global config table sharing data between scripts
_G.Custom = {
  helpers = require("helpers"),
  config = require("config"),
  metadata = require("metadata"),
}

require("core")
if not vim.g.vscode then
  require("plugins")
end
