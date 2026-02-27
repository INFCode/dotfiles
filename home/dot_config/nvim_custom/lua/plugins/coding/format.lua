local plugin = Custom.plugin

local M = {}

local register_plugin = function()
  MiniDeps.add("stevearc/conform.nvim")
end

local configure_conform = function(formatters_by_ft)
  plugin.later(function()
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
  end)
end

function M.setup(formatters_by_ft)
  register_plugin()
  configure_conform(formatters_by_ft)
end

return M
