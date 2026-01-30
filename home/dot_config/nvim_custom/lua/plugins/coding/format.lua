MiniDeps.add("stevearc/conform.nvim")

local all_formatters_by_ft = {
  python = {
    "ruff_fix",
    "ruff_format",
    "ruff_organize_imports",
  },
}

local get_active_formatters = function()
  return _G.Custom.helpers.index(all_formatters_by_ft, _G.Custom.config.languages)
end

MiniDeps.later(function()
  local conform = require("conform")
  conform.setup({
    formatters_by_ft = get_active_formatters(),
    default_format_opts = {
      lsp_format = "fallback",
    },
    format_on_save = {
      timeout_ms = 500,
    },
  })
end)
