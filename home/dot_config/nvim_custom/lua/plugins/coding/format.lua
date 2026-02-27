local plugin = Custom.plugin

local M = {}

local configure_conform = function(formatters_by_ft)
  local conform = require("conform")
  conform.setup({
    formatters_by_ft = formatters_by_ft or {},
    default_format_opts = {
      lsp_format = "fallback",
    },
    format_on_save = {
      timeout_ms = 500,
    },
  })
end

function M.setup(formatters_by_ft)
  plugin.later(function()
    plugin.add("stevearc/conform.nvim")
    configure_conform(formatters_by_ft)
  end)
end

return M
