MiniDeps.add("stevearc/conform.nvim")

MiniDeps.later(function()
  local conform = require("conform")
  conform.setup({
    formatters_by_ft = {
      -- TODO: Fill this
    },
    default_format_opts = {
      lsp_format = "fallback",
    },
    format_on_save = {
      timeout_ms = 500,
    },
  })
end)
