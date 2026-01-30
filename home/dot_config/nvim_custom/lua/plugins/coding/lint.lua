MiniDeps.add("mfussenegger/nvim-lint")

local all_linters_by_ft = {}

local get_active_linters = function()
  return _G.Custom.helpers.index(all_linters_by_ft, _G.Custom.config.languages)
end

MiniDeps.later(function()
  require('lint').linters_by_ft = get_active_linters()
end)
