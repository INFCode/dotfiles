MiniDeps.add("mfussenegger/nvim-lint")
MiniDeps.later(function()
  require('lint').linters_by_ft = {
    -- TODO: Fill this
  }
end)
