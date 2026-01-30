-- mini.deps bootstrap
local path_package = vim.fn.stdpath("data") .. "/site/"
local deps_path = path_package .. "pack/deps/start/mini.deps"
if not vim.loop.fs_stat(deps_path) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/echasnovski/mini.deps",
    deps_path,
  })
end
vim.opt.rtp:prepend(deps_path)

local deps = require("mini.deps")
deps.setup({ path = { package = path_package } })

require("plugins.colorscheme")
require("plugins.visual")
require("plugins.ui")
require("plugins.structure")
require("plugins.cmp")
require("plugins.lsp")
require("plugins.format")
require("plugins.lint")
require("plugins.git")
