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

require("mini.deps").setup({ path = { package = path_package } })

Custom.plugin = {
  add = MiniDeps.add,
  now = MiniDeps.now,
  later = MiniDeps.later,
  now_if_args = vim.fn.argc(-1) > 0 and MiniDeps.now or MiniDeps.later,
}

require("plugins.ui")
require("plugins.motion")
require("plugins.structure")
require("plugins.coding")
require("plugins.git")
require("plugins.ai")
