local plugin = Custom.plugin

local M = {}

local register_plugin = function()
  MiniDeps.add("mfussenegger/nvim-lint")
end

local configure_lint = function(linters_by_ft)
  plugin.later(function()
    require("lint").linters_by_ft = linters_by_ft or {}
  end)
end

function M.setup(linters_by_ft)
  register_plugin()
  configure_lint(linters_by_ft)
end

return M
