local plugin = Custom.plugin

local M = {}

local configure_lint = function(linters_by_ft)
  require("lint").linters_by_ft = linters_by_ft or {}
end

function M.setup(linters_by_ft)
  plugin.later(function()
    plugin.add("mfussenegger/nvim-lint")
    configure_lint(linters_by_ft)
  end)
end

return M
